package main

import (
	"fmt"
	"log"

	"github.com/kitech/gopp"
	"github.com/kitech/gopp/cgopp"
	_ "github.com/kitech/gopp/cgopp"
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
	go bgproc()
}

func bgproc() {
	for i := 0; ; i++ {
		gopp.SleepSec(3)
		log.Println(i)
		callqml(fmt.Sprintf("thisgo,callqml %d", i))
	}
}

// /// ffi section
//
//export qmlinvokenative
func qmlinvokenative(jstr *C.char) *C.char {
	log.Println("qmlinvokenative", jstr)
	var str = C.GoString(jstr)

	var res = str + " [goadded]"
	return C.CString(res)
}

//export qmlsetcallbackfn
func qmlsetcallbackfn(fnptr voidptr) {
	qtemitcallqmlfnptr = fnptr
	gopp.NilPrint(fnptr, "set nil fnptr???")
}

var qtemitcallqmlfnptr = voidptr(nil)

func callqml(jstr string) {
	gopp.NilPrint(qtemitcallqmlfnptr, "fnptr nil")
	// C.qtemitcallqml(C.CString(jstr))
	var jstr4c = cgopp.StrtoCharpRef(&jstr)
	cgopp.Litfficallg(qtemitcallqmlfnptr, jstr4c)
}
