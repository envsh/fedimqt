package main

import (
	"log"
	"os"
	"runtime"

	"github.com/envsh/fedind/guiclish"
	"github.com/kitech/gopp"
	"github.com/kitech/gopp/cgopp"
	"github.com/kitech/minqt"
	"golang.org/x/sys/unix"
)

var abtui = &aboutui{}

type aboutui struct {
}

func (me *aboutui) SetPairs() {
	minqt.RunonUithread(me.implSetPairs)
}
func (me *aboutui) implSetPairs() {
	{
		qtver := minqt.QVersion()
		obj := qmlcpm.rootobj.FindChild("rtqtver")
		obj.SetProperty("text", qtver)
		// guiclish.EmitEventFront("notice", "rtqtver", qtver)
	}
	{
		dir, _ := os.Getwd()
		obj := qmlcpm.rootobj.FindChild("workdir")
		obj.SetProperty("text", dir)

		// guiclish.EmitEventFront("notice", "workdir", dir)
	}
	{
		gover := runtime.Version()
		obj := qmlcpm.rootobj.FindChild("rtgover")
		obj.SetProperty("text", gover)
		// guiclish.EmitEventFront("notice", "rtgover", gover)
	}
	if true {
		v := unix.Utsname{}
		err := unix.Uname(&v)
		gopp.ErrPrint(err)
		// gopp.Info(string(v.Sysname[:]), string(v.Release[:]), string(v.Version[:]))

		gover := unameline(&v)
		// gover = string(v.Sysname[:]) + string(v.Release[:])
		// gopp.Debug(gover, len(strings.TrimRight(string(v.Sysname[:]), "0")))
		obj := qmlcpm.rootobj.FindChild("unameinfo")
		obj.SetProperty("text", gover)
	}
}

func unameline(o *unix.Utsname) string {
	var zerofn = func(r rune) bool {
		if r == 0 {
			return false
		}
		return true
	}
	_ = zerofn
	var s string
	s += cgopp.GoString(cgopp.CStringaf(string(o.Sysname[:])))
	s += cgopp.GoString(cgopp.CStringaf(string(o.Version[:])))

	return s
}

// ////
var msglstwin = &MsglstPage{}

type MsglstPage struct {
}

// todo
func (me *MsglstPage) Scrollvto(top bool) {
	obj1 := qmlcpm.rootobj.FindChild("scroll1")
	gopp.NilPrint(obj1.Cthis, "cannot get scroll1", qmlcpm.rootobj)
	obj2 := obj1.Property("ScrollBar")
	gopp.NilPrint(obj2.Cthis, "cannot get ScrollBar", obj1)
	obj3 := obj1.Property("vertical")
	gopp.NilPrint(obj3.Cthis, "cannot get vertical", obj1)

	// defer obj2.Dtor()
	// defer obj3.Dtor()

	// since noway direct set position value, just callback qmljs
	guiclish.EmitEventFront("msglst.scrollvto", top)

	/*
	   let sbv = scroll1.ScrollBar.vertical;
	   	if (top) {
	   	    sbv.position = 0.0;
	   	}else{
	   	    // Tspp.debug("nowpos", sbv.position);
	   	    sbv.position = 1.0 - sbv.size // scroll1.contentHeight - scroll1.height;
	   	    // Tspp.debug("cch", scroll1.contentHeight, "winh", scroll1.height);
	   	}
	*/
}

func (me *MsglstPage) Setccfmt(f int) {
	gopp.Debug(f)
	obj1 := qmlcpm.rootobj.FindChild("msglstwin")
	obj1.SetProperty("txtccfmt", f)
}

var sndmsgpfxs = map[string]string{"dftim": "dftimpfx： ", "gptcf": "请使用中文完成对话：", "cmd": "!"}

func (me *MsglstPage) Sendmsg() {
	obj1 := qmlcpm.rootobj.FindChild("msgsndmode")
	obj2 := qmlcpm.rootobj.FindChild("usriptmsg")
	sndmode := obj1.Property("currentValue")
	iptmsg := obj2.Property("text")
	log.Println(sndmode, iptmsg)
	log.Println(sndmode.Tostr(), iptmsg.Tostr())
	// defer sndmode.Dtor()
	// defer iptmsg.Dtor()

	msgpfx := sndmsgpfxs[sndmode.Tostr()]
	outmsg := msgpfx + iptmsg.Tostr()

	log.Println("outmsg...", outmsg)

	/*
	   let sndmode = msgsndmode.currentValue;
	   let msgpfx = Sss.getsndmsgpfx(sndmode);
	   let msg = usriptmsg.text;
	   msg = msgpfx + msg;
	   Tspp.debug("usriptmsg", msg.length, sndmode, msg);
	*/
}
