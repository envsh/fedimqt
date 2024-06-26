package main

import (
	"fmt"
	"log"
	mrand "math/rand"
	"os"
	"runtime"
	rtdbg "runtime/debug"
	"time"

	"github.com/ebitengine/purego"
	_ "github.com/ebitengine/purego"
	"github.com/envsh/fedind/envcfg"
	"github.com/envsh/fedind/guiclish"
	"github.com/kitech/gopp"
	"github.com/kitech/gopp/cgopp"
	_ "github.com/kitech/gopp/cgopp"
	"github.com/kitech/minqt"

	// _ "github.com/jupiterrider/ffi"

	_ "github.com/kitech/minqt"
)

// #cgo LDFLAGS: -L../ -lhelloworld

/*
// extern void qtemitcallqml(char*);



*/
import "C"

// ////
var mainrun = false

func main() {
	//
	mainrun = true
	// log.Println(envcfg.Exepath)

	// gomaininit() // called in main.init()
	gomainexe()
}

//extern gomainexe()
func gomainexe() {
	runtime.LockOSThread()
	symx := cgopp.Dlsym0("maincxxqml0")
	var maincxxqml0 func() int
	purego.RegisterFunc(&maincxxqml0, uintptr(symx))
	log.Println("Running... maincxxqml0,", symx, maincxxqml0)
	rv := maincxxqml0() //
	// cpp will run loop forever
	// gopp.Forever()
	gopp.Info("App exit...", rv, time.Since(gopp.StartTime))
}

// as main of sharedlib
func init() {
	rtdbg.SetGCPercent(30)
	runtime.GOMAXPROCS(2)

	cgopp.JNI_OnLoad_Callback = android_javajni_onload
	gopp.Info("", runtime.GOOS, envcfg.Mynode, envcfg.Exepath)
	gomaininit()
	if runtime.GOOS == "android" {
		// gomainexe()
	}

}

func android_javajni_onload() {
	gopp.Println("hehhehe")
	os.Setenv("QT_ANDROID_DEBUGGER_MAIN_THREAD_SLEEP_MS", "123")

}

// this nonblock

//extern gomaininit
func gomaininit() {
	log.SetFlags(log.Flags() | log.Lshortfile ^ log.Ldate)
	log.Println("mainorinit")
	interopinit()
	guiclish.OnlineStatusSetcb(onnetonlinestatus)
	guiclish.MatrixEventSetcb(onmtxevtcb)
	guiclish.SetNetreqNotecb(onnetreqnotice)
	go bgproc()
	go uptimebgproc()
	// go fedimac.Appclientmain()
	// guiclish.Locdb()
	// startthinmtxproc()

	time.AfterFunc(gopp.DurandMs(999, 999), func() {

		if false {
			qtver := minqt.QRuntimeVersion()
			// qtver := "2.3.4"
			// log.Println(qtver)
			guiclish.EmitEventFront("notice", "rtqtver", qtver)
			dir, _ := os.Getwd()
			guiclish.EmitEventFront("notice", "workdir", dir)
			gover := runtime.Version()
			guiclish.EmitEventFront("notice", "rtgover", gover)
		}
		if true {
			abtui.SetPairs()
		}

	})
}

func bgproc() {
	{

		v := minqt.QVarintNew(12345)
		// log.Println(v)
		log.Println(v, v.Toint())
		// v.Dtor()
		v = minqt.QVarintNew(int64(888))
		log.Println(v, v.Toint64())
		// v.Dtor()

		v = minqt.QVarintNew("abcde")
		log.Println(v, v.Tostr())
		// v.Dtor()

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
func uptimebgproc() {
	for {
		if qmlcpm == nil {
			gopp.SleepSec(1)
			continue
		}

		mainui.uptimesetuit()
		gopp.SleepSec(3)

		// btime := time.Now()
		// for i := 0; i < 100; i++ {
		// 	minqt.Dlsym0("QObjectProperty1")
		// }
		// log.Println(time.Since(btime))

		if true {
			// 这个数据肯定是不大的，内存大全在qml那里，
			// qml profile 怎么到处都是allocate 64KB???
			// memlen := DeepSizeof(qmlcpm.msglstmdl, 0)
			// log.Println("memlen", memlen)

			mo := minqt.QMetaObjectof0()
			mo.InvokeQmlmf(qmlcpm.rootobj, "dircallbygo", mrand.Int(), gopp.RandomStringAlphaMixed(9))

			minqt.Qmljsgc2(qmlcpm.rootobj)
		}
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

func onmtxevtcb(hkt *guiclish.Hooktaskqst, msgo *guiclish.Messagestable, isnew bool, hasmore bool) (added bool) {
	mdl := qmlcpm.msglstmdl
	mdl2 := qmlcpm.grplstmdl

	romrec := &romrow{}

	// log.Println(mdl, hkt, msgo, isnew)
	if hkt != nil {
		// guiclish.EmitEventFront("loadmsgrt", isnew, hkt.Hki)
		added = mdl.Add(hkt.Hki)
		romrec.RoomsTable = *hkt.Hki.ExtractRoomItem()
	}
	if msgo != nil {
		// guiclish.EmitEventFront("loadmsgrt", isnew, msgo)
		added = mdl.Add(msgo)
		romrec.RoomsTable = *msgo.ExtractRoomItem()
	}
	if romrec.Roomid != "" {
		mdl2.Add(romrec)
	}
	if !hasmore {
		minqt.RunonUithread(func() {
			mainui.upstatusmc()
			mainui.upstatusrc()
		})
	}
	return
}
func onnetreqnotice(begin bool, len int) {
	// guiclish.EmitEventFront("netreqnote", begin, len)
	mainui.onnetreqnote(begin, len)
}
func onnetonlinestatus(online bool, errmsg string) {
	// guiclish.EmitEventFront("netstatus", online, errmsg)
	mainui.onnetstatus(online, errmsg)
}

// /// ffi section
//
//export qmlinvokenative
func qmlinvokenative(jstr *C.char, n usize, retstr *voidptr, retlen *usize) *C.char {
	retstr2 := guiclish.InvokeProcessor(voidptr(jstr), n)
	*retlen = usize(len(retstr2))
	// *retstr = voidptr(C.CString(retstr2))
	ret4c := cgopp.CStringaf(retstr2)
	*retstr = ret4c

	return nil
}

var qtemitcallqmlfnptr = voidptr(nil)

func callqml(jstr string) {
	gopp.NilPrint(qtemitcallqmlfnptr, "fnptr nil")
	// C.qtemitcallqml(C.CString(jstr))
	// var jstr4c = cgopp.StrtoCharpRef(&jstr)
	jstr4c := cgopp.CStringaf(jstr)
	// defer cgopp.Cfree(jstr4c)
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
