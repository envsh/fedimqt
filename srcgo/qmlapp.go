package main

/*
// extern void qtemitcallqml(char*);
*/
import "C"
import (
	"fmt"
	"log"
	mrand "math/rand"
	"runtime"
	"time"

	"github.com/envsh/fedind/guiclish"
	"github.com/kitech/gopp"
	"github.com/kitech/minqt"
)

var qmlape minqt.QQmlApplicationEngine
var qmlcpm *qmlcompman

// usage: in cpp
// first call, connect signal
// second call, run flow back

//export qmlappenginenew
func qmlappenginenew(step int) voidptr {
	// nowt := time.Now()
	// defer gopp.Println(step, time.Since(nowt))
	// gopp.Info(step)

	switch step {
	case 0:
		// gopp.Info(step)
		e := minqt.QQmlApplicationEngineNew()
		qmlape = e
		// gopp.Info(step)
		// gopp.SleepSec(3)
		return e.Cthis

	case 1:

	case 2:

	case 3: // qmlApplicationEngineCreated
		onQmlAppEngineCreated()

	default:
		gopp.Println("not expect", step)
	}

	return nil
}

func onQmlAppEngineCreated() {
	gopp.Println("hereee")
	// time.AfterFunc(gopp.DurandSec(1, 2), func() {
	robj := qmlape.RootObject()
	qmlcpm = qmlcompmannew(robj)
	qmlcpm.qtobj = minqt.QtObjectCreate(qmlape)

	if false {
		tstadditems()
	}
	time.AfterFunc(gopp.DurandSec(1, 2), testqmlop2)
	// })

	//
	guiclish.OnFrontuiCreated()
	if true {
		// let rv2 = invokebkd("getcfg", "", "lastaccountline");
		rv := guiclish.OnFrontuiGetcfg("", "lastaccountline")
		if true { // for test login flow
			rv = ""
		}
		if rv == "" {
			// invokebkd('listcfg', 'accountline');
			lines := guiclish.OnFrontuiListcfg("accountline")
			// todo set loginui accout list
			gopp.GOUSED(lines)
			// loginui.onGotAccounts(jso.Retv);
			for _, line := range lines {
				guiclish.EmitEventFront("setloginline", line)
			}
			// calljs("switchpageidx", 2);
			mainui.switchpageidx(2)
		} else {
			ok := guiclish.OnFrontuiLoginAccountline(rv)
			gopp.FalsePrint(ok, "login failed", rv)
			if ok {
				mainui.switchpageidx(0)
			}
		}
	}

	if false && runtime.GOOS == "android" {
		go func() {

			for i := range gopp.RangeA(50) {
				item := &guiclish.Hookinfost{}

				item.Channame = fmt.Sprintf("Channame%d", i)
				item.Channel = fmt.Sprintf("Channel%d", i)
				item.Content = fmt.Sprintf("Content%d", i)
				item.Mtimems = time.Now().UnixMilli() - int64(mrand.Int()%10000000)
				item.Eventid = fmt.Sprintf("$%d", item.Mtimems)

				qmlcpm.msglstmdl.Add(item)
			}

			minqt.RunonUithread(mainui.upstatusmc)
			minqt.RunonUithread(mainui.upstatusrc)
		}()
	}
}

func init() {
	var roleNames = map[int]string{256: "Eventid", 257: "Content", 258: "Mtimems", 259: "Roomid", 260: "Roomname", 261: "Sender", 262: "Mtimemsui", 263: "Dtime", 264: "Mtimemsuitip", 265: "Msgtopline", 266: "Msgbtmline", 267: "Msgmd2html"}
	minqt.RegisterModelRoleNames("msglstmdl", gopp.MapValues(roleNames)...)
}

type tstdata struct {
	seq int
}

func (me *tstdata) Data(name string) any {
	return fmt.Sprintf("tstddd %d(%s)", me.seq, name)
}
func (me *tstdata) DedupKey() string {
	return fmt.Sprintf("%d", me.seq)
}
func (me *tstdata) OrderKey() int64 {
	return int64(me.seq)
}

func tstadditems() {
	mdl := qmlcpm.msglstmdl
	for i := range gopp.RangeA(13) {
		d := &tstdata{}
		d.seq = i
		mdl.Add(d)
	}

}
func testqmlop2() {
	// log.Println("hehehe")
	// robj := qmlcpm.rootobj
	stkwx := qmlcpm.stkwin
	stkw := minqt.QStackViewof(stkwx.Cthis)
	depthx := stkwx.Property("depth")
	depth := depthx.Toint()
	for i := range gopp.RangeA(depth + 1) {
		item := stkw.Get(i)
		log.Println(i, item, depth)
		if item.Cthis == nil {
			break
		}
	}
}

type qmlcompman struct {
	qtobj minqt.QtObject // in .qml, it Qt global object

	/////
	rootobj   minqt.QObject
	aboutobj  minqt.QObject
	msglstwin minqt.QObject
	romlstwin minqt.QObject
	loginui   minqt.QObject
	logui     minqt.QObject

	/////
	stbmsgcntlb  minqt.QObject
	stbgrpcntlb  minqt.QObject
	stbcurwinlb  minqt.QObject
	stblastloglb minqt.QObject
	stbnetolnlb  minqt.QObject
	stbnetbwlb   minqt.QObject
	stbuptimelb  minqt.QObject

	stkwin   minqt.QObject
	stkitems []minqt.QObject

	msglstmdlco minqt.QObject
	msglstmdl   *minqt.ListModelBase
	grplstmdlco minqt.QObject
	grplstmdl   *minqt.ListModelBase

	/////

	/////

}

func qmlcompmannew(rootobj minqt.QObject) *qmlcompman {
	me := &qmlcompman{}
	me.rootobj = rootobj
	robj := rootobj

	xobj := robj.FindChild("aboutui")
	// log.Println(aboutobj)
	me.aboutobj = xobj

	me.msglstwin = robj.FindChild("msglstwin")
	me.romlstwin = robj.FindChild("romlstwin")
	me.loginui = robj.FindChild("loginui")
	me.logui = robj.FindChild("logui")

	xobj = robj.FindChild("mainui.stb.msgcntlb")
	me.stbmsgcntlb = xobj

	xobj = robj.FindChild("mainui.stb.grpcntlb")
	me.stbgrpcntlb = xobj

	xobj = robj.FindChild("mainui.stb.curwinlb")
	me.stbcurwinlb = xobj

	xobj = robj.FindChild("mainui.stb.lastloglb")
	me.stblastloglb = xobj

	xobj = robj.FindChild("mainui.stb.uptimelb")
	me.stbuptimelb = xobj

	xobj = robj.FindChild("msglstmdl")
	// mdl := (*minqt.ListModelBase)(xobj.Cthis)
	goobjx := xobj.Property("goobj")
	// defer goobjx.Dtor()
	log.Println(goobjx, goobjx.Toint64())
	goobj := minqt.ListModelBaseof(goobjx.Toint64())
	// log.Println(goobj)
	// log.Println(goobj.RowCount())
	if goobj.RowCount() > 0 {
	}
	me.msglstmdlco = xobj
	me.msglstmdl = goobj

	{
		xobj := robj.FindChild("grplstmdl")
		goobjx := xobj.Property("goobj")
		goobj := minqt.ListModelBaseof(goobjx.Toint64())
		me.grplstmdlco = xobj
		me.grplstmdl = goobj
	}

	xobj = robj.FindChild("stackwin")
	me.stkwin = xobj
	// gopp.Info(xobj, "stackwin?") // nice works
	me.stkitems = append(me.stkitems, me.msglstwin, me.romlstwin, me.loginui, me.logui, me.aboutobj)
	// log.Println(me.stkitems)

	log.Println(me)
	return me
}
