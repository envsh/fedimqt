package main

import (
	"fmt"
	"log"
	"os"
	"runtime"
	"strings"
	"time"

	"github.com/envsh/fedind/envcfg"
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
		qtver := minqt.QCompVersion()
		obj := qmlcpm.rootobj.FindChild("compqtver")
		obj.SetProperty("text", qtver)
	}
	{
		qtver := minqt.QRuntimeVersion()
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
	{
		gover := envcfg.Exepath
		obj := qmlcpm.rootobj.FindChild("appexe")
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

		{
			gover := unameline2(&v)
			obj := qmlcpm.rootobj.FindChild("archinfo")
			obj.SetProperty("text", gover)
		}
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
	// s += cgopp.GoString(cgopp.CStringaf(string(o.Sysname[:])))
	s += cgopp.GoString(cgopp.CStringaf(string(o.Version[:])))
	// s = s[15:]
	s = gopp.Lastof(strings.Split(s, ": ")).Str()

	return s
}

// arch
func unameline2(o *unix.Utsname) string {
	var zerofn = func(r rune) bool {
		if r == 0 {
			return false
		}
		return true
	}
	_ = zerofn
	var s string
	s += cgopp.GoString(cgopp.CStringaf(string(o.Sysname[:])))
	s += " "
	s += cgopp.GoString(cgopp.CStringaf(string(o.Machine[:])))
	s += " Kernel Version "
	s += cgopp.GoString(cgopp.CStringaf(string(o.Release[:])))

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
	sndmodex := obj1.Property("currentValue")
	sndmode := sndmodex.Tostr()
	iptmsgx := obj2.Property("text")
	iptmsg := iptmsgx.Tostr()
	log.Println(sndmode, iptmsg)
	log.Println(sndmodex.Tostr(), iptmsgx.Tostr())
	// defer sndmode.Dtor()
	// defer iptmsg.Dtor()

	msgpfx := sndmsgpfxs[sndmode]
	outmsg := msgpfx + iptmsg

	log.Println("outmsg...", sndmode, outmsg)

	go me.implSendmsg(sndmode, outmsg)

	/*
	   let sndmode = msgsndmode.currentValue;
	   let msgpfx = Sss.getsndmsgpfx(sndmode);
	   let msg = usriptmsg.text;
	   msg = msgpfx + msg;
	   Tspp.debug("usriptmsg", msg.length, sndmode, msg);
	*/
}
func (me *MsglstPage) implSendmsg(sndmode string, outmsg string) {
	// todo and sending msg to ui/db???
	jso, err := guiclish.SendmsgGptcf(sndmode, outmsg)
	gopp.ErrPrint(err, sndmode, outmsg)
	// msg.Dtime = "0s0ms"

	var addok bool
	if err == nil {
		msgo := &guiclish.Messagestable{}
		msgo.Content = jso.Get("Content").MustString()
		msgo.Sender = "gptcfai"
		msgo.Feditype = "gptcf"
		// msgo.Fedisite
		msgo.Roomid = "mainline@cf"
		msgo.Roomname = "mainline"
		nowt := time.Now()
		msgo.Eventid = fmt.Sprintf("$%d", nowt.UnixMicro())
		msgo.Mtimems = nowt.UnixMilli()
		msgo.Ctimems = nowt.UnixMilli()
		// msgo.Mtimemsui = guiclish.TimeToHhmm(nowt)

		addok = qmlcpm.msglstmdl.Add(msgo)
	}

	if err != nil {
		logui.Addlog(err.Error())
	}
	minqt.RunonUithread(func() {
		if err != nil {
			// some notify info???
			mainui.upstatusll(err.Error())
			return
		}
		if addok {
			mainui.upstatusmc()
		}
	})
}

func (me *MsglstPage) trimsndmsgpfx(modename string, msg string) string {
	pfx := sndmsgpfxs[modename]
	if pfx != "" && strings.HasPrefix(msg, pfx) {
		return msg[len(pfx):]
	}
	return msg
	/*
	   let pfx = vss.sndmsgpfxs[name];
	   if (pfx != '' && msg.startsWith(pfx)) {
	       return msg.substring(pfx.length);
	   }
	   return msg;
	*/
}

// //////////
var romlstui = &RomlstPage{}

type RomlstPage struct {
}

func init() {
	// roleNames := []string{"Index", "Content", "Ctimems", "Ctimemsui"}
	// namesx := gopp.Mapdo(logrow{}, func(i int, kx, vx any) any {
	// 	return kx //[]any{vx}
	// })
	// names := gopp.ToStrs(namesx.([]any)...)
	// roleNames := append(names, "Ctimemsui")
	// log.Println(roleNames)
	// minqt.RegisterModelRoleNames("loglstmdl", roleNames...)
	minqt.RegisterModelRoleNames2("grplstmdl", guiclish.RoomsTable{},
		"Ctimemsui", "Mtimemsui", "Mtimemsuitip", "Lastmsui", "Content", "Lastmsui")
}

type romrow struct {
	guiclish.RoomsTable
	Content string // last msg
	Lastms  int64  // last msg
}

func (me *romrow) Data(name string) any {
	switch name {
	case "Content":
		return name + ".unimpl"
	case "Lastmsui":
		return "Lastmsui" + ".umimpl"
	case "Lastms":
		return me.Lastms
	default:
		return me.RoomsTable.Data(name)
	}
}
func (me *romrow) DedupKey() string {
	return me.RoomsTable.DedupKey()
}
func (me *romrow) OrderKey() int64 {
	return me.RoomsTable.OrderKey()
}

// //////////
var logui = &loguist{}

type loguist struct {
	idx int64
}

func init() {
	// roleNames := []string{"Index", "Content", "Ctimems", "Ctimemsui"}
	// namesx := gopp.Mapdo(logrow{}, func(i int, kx, vx any) any {
	// 	return kx //[]any{vx}
	// })
	// names := gopp.ToStrs(namesx.([]any)...)
	// roleNames := append(names, "Ctimemsui")
	// log.Println(roleNames)
	// minqt.RegisterModelRoleNames("loglstmdl", roleNames...)
	minqt.RegisterModelRoleNames2("loglstmdl", logrow{}, "Ctimemsui")
}

type logrow struct {
	Index   int
	Content string
	Ctimems int64
	Mtimems int64
	Dupcnt  int
}

func (me *logrow) Data(name string) any {
	// gopp.Println(name, me.Index)
	switch name {
	case "Index":
		return me.Index
	case "Content":
		return me.Content
	case "Ctimems":
		return me.Ctimems
	case "Ctimemsui":
		return gopp.TimeToFmt1(time.UnixMilli(me.Ctimems))
	}
	return fmt.Sprintf("unkname %s", name)
}
func (me *logrow) DedupKey() string {
	return fmt.Sprintf("%d", me.Ctimems)
}
func (me *logrow) OrderKey() int64 {
	return -1 // me.Ctimems
}

const maxuilogcnt = 200
const deluilogcnt = 33

// todo 最多保留200条,如果多于200则删除旧的
func (me *loguist) Addlog(logstr string) {
	xobj := qmlcpm.rootobj.FindChild("loglstmdl")
	goobjx := xobj.Property("goobj")
	goobj := minqt.ListModelBaseof(goobjx.Toint64())
	// gopp.Println("loglstmdl obj", goobj)

	nowt := time.Now()
	item := &logrow{}
	item.Content = logstr
	item.Ctimems = nowt.UnixMilli()
	item.Index = goobj.RowCount()
	item.Index = int(me.idx)
	me.idx++

	addok := goobj.Add(item)
	if addok {
		// scroll
	}

	oldcnt := goobj.RowCount()
	if goobj.RowCount() > maxuilogcnt {
		goobj.Delold(deluilogcnt)
	}
	newcnt := goobj.RowCount()
	if newcnt != oldcnt {
		// gopp.Println("remove some", oldcnt, "=>", newcnt)
	}

	dds := gopp.DeepSizeof(goobj, 0)
	minqt.RunonUithread(func() {
		o := qmlcpm.rootobj.FindChild("logcntlb")
		o.SetProperty("text", fmt.Sprintf("LC: %d, DDS: %d ...", newcnt, dds))
	})

	/*
		let item = {};
		item.number = item.Content = logstr;
		listView.model.append(item);

		scroll1.ScrollBar.vertical.position = 1.0 - scroll1.ScrollBar.vertical.size;
	*/
}

func (me *loguist) upsetcntlb() {

}
