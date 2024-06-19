package main

import (
	"fmt"
	"log"
	"os"
	"runtime"
	"time"

	"github.com/ebitengine/purego"
	_ "github.com/ebitengine/purego"
	"github.com/envsh/fedind/guiclish"
	"github.com/kitech/gopp"
	"github.com/kitech/gopp/cgopp"
	_ "github.com/kitech/gopp/cgopp"
	"github.com/kitech/minqt"

	// _ "github.com/jupiterrider/ffi"

	_ "github.com/kitech/minqt"
)

/*
// extern void qtemitcallqml(char*);
*/
import "C"

// ////
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
	guiclish.OnlineStatusSetcb(onnetonlinestatus)
	guiclish.MatrixEventSetcb(onmtxevtcb)
	guiclish.SetNetreqNotecb(onnetreqnotice)
	go bgproc()
	// go fedimac.Appclientmain()
	// guiclish.Locdb()
	// startthinmtxproc()

	time.AfterFunc(gopp.DurandMs(999, 999), func() {
		qtver := minqt.QVersion()
		// qtver := "2.3.4"
		// log.Println(qtver)
		guiclish.EmitEventFront("notice", "rtqtver", qtver)
		dir, _ := os.Getwd()
		guiclish.EmitEventFront("notice", "workdir", dir)
		gover := runtime.Version()
		guiclish.EmitEventFront("notice", "rtgover", gover)
	})
}

func bgproc() {
	{

		v := minqt.QVarintNew(12345)
		// log.Println(v)
		log.Println(v, v.Toint())
		v.Dtor()
		v = minqt.QVarintNew(int64(888))
		log.Println(v, v.Toint64())
		v.Dtor()

		v = minqt.QVarintNew("abcde")
		log.Println(v, v.Tostr())
		v.Dtor()

		var x = 123
		v = minqt.QVarintNew((voidptr)(&x))
		log.Println(v, v.Toptr(), &x)
	}

	for i := 0; ; i++ {
		gopp.SleepSec(33)
		log.Println("loopcnt", i, 33)
		// callqml(fmt.Sprintf("thisgo,callqml %d", i))
		guiclish.EmitEventFront("notice", fmt.Sprintf("thisgo,callqml %d", i))
	}
}
func startthinmtxproc() {
	mtxsrv := ""
	mtxusr := ""
	mtxacctk := ""
	go func() {
		guiclish.NonhttpThinmtxproc(mtxsrv, mtxusr, mtxacctk)
		log.Println("main.thinmtxproc done", mtxsrv, mtxusr, mtxacctk)
	}()
}
func onmtxevtcb(hkt *guiclish.Hooktaskqst, msgo *guiclish.Messagestable, isnew bool) {
	if hkt != nil {
		guiclish.EmitEventFront("loadmsgrt", isnew, hkt.Hki)
	}
	if msgo != nil {
		guiclish.EmitEventFront("loadmsgrt", isnew, msgo)
	}
}
func onnetreqnotice(begin bool, len int) {
	guiclish.EmitEventFront("netreqnote", begin, len)
}
func onnetonlinestatus(online bool, errmsg string) {
	guiclish.EmitEventFront("netstatus", online, errmsg)
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
	// var jstr4c = cgopp.StrtoCharpRef(&jstr)
	jstr4c := cgopp.CString(jstr)
	defer cgopp.Cfree(jstr4c)
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
