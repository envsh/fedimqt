package main

import (
	"fmt"
	"log"

	"github.com/ebitengine/purego"
	_ "github.com/ebitengine/purego"
	"github.com/envsh/fedind/guiclish"
	"github.com/kitech/gopp"
	"github.com/kitech/gopp/cgopp"
	_ "github.com/kitech/gopp/cgopp"
	// _ "github.com/jupiterrider/ffi"
)

/*
// extern void qtemitcallqml(char*);
*/
import "C"

var mainrun = false

func main() {
	//
	mainrun = true
}

// as main of sharedlib
func init() {
	if !mainrun {
		mainorinit()
	}
}

func mainorinit() {
	log.SetFlags(log.Flags() | log.Lshortfile ^ log.Ldate)
	log.Println("mainorinit")
	interopinit()
	go bgproc()
	// go fedimac.Appclientmain()
}

func bgproc() {

	for i := 0; ; i++ {
		gopp.SleepSec(3)
		log.Println(i)
		// callqml(fmt.Sprintf("thisgo,callqml %d", i))
		guiclish.EmitEventFront("notice", fmt.Sprintf("thisgo,callqml %d", i))
	}
}

// /// ffi section
//
//export qmlinvokenative
func qmlinvokenative(jstr *C.char, n usize, retstr *voidptr, retlen *usize) *C.char {
	retstr2 := guiclish.InvokeProcessor(voidptr(jstr), n)
	*retlen = usize(len(retstr2))
	*retstr = voidptr(C.CString(retstr2))
	return nil
}

var qtemitcallqmlfnptr = voidptr(nil)

func callqml(jstr string) {
	gopp.NilPrint(qtemitcallqmlfnptr, "fnptr nil")
	// C.qtemitcallqml(C.CString(jstr))
	var jstr4c = cgopp.StrtoCharpRef(&jstr)
	cgopp.Litfficallg(qtemitcallqmlfnptr, jstr4c)
}

func interopinit() {
	fnname := "qtemitcallqml"
	guiclish.EmitEventFrontFuncName = fnname
	sym, err := purego.Dlsym(purego.RTLD_DEFAULT, fnname)
	gopp.ErrPrint(err)
	log.Println(fnname, sym)
	qtemitcallqmlfnptr = voidptr(sym)

	{ // 找go自己定义的sym
		fnname := "qmlinvokenative"
		sym, err := purego.Dlsym(purego.RTLD_DEFAULT, fnname)
		gopp.ErrPrint(err)
		log.Println(fnname, sym)
	}
}