package main

/*
// extern void qtemitcallqml(char*);
*/
import "C"
import (
	"fmt"
	"log"
	"time"

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
	gopp.Info(step)
	switch step {
	case 0:
		gopp.Info(step)
		e := minqt.QQmlApplicationEngineNew()
		qmlape = e
		gopp.Info(step)
		// gopp.SleepSec(3)
		return e.Cthis

	case 1:

	case 2:

	case 3:
		robj := qmlape.RootObject()
		qmlcpm = qmlcompmannew(robj)

		if false {
			tstadditems()
		}
		time.AfterFunc(gopp.DurandSec(1, 2), testqmlop2)
	default:
		log.Println("not expect", step)
	}

	return nil
}

func init() {
	var roleNames = map[int]string{256: "Eventid", 257: "Content", 258: "Mtimems", 259: "Roomid", 260: "Roomname", 261: "Sender", 262: "Mtimemsui", 263: "Dtime"}
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
	log.Println("hehehe")
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
	/////
	rootobj  minqt.QObject
	aboutobj minqt.QObject

	/////
	stbmsgcntlb  minqt.QObject
	stbgrpcntlb  minqt.QObject
	stblastloglb minqt.QObject
	stbnetolnlb  minqt.QObject
	stbnetbwlb   minqt.QObject
	stbuptimelb  minqt.QObject

	stkwin   minqt.QObject
	stkitems []minqt.QObject

	msglstmdlco minqt.QObject
	msglstmdl   *minqt.ListModelBase

	/////

	/////

}

func qmlcompmannew(rootobj minqt.QObject) *qmlcompman {
	me := &qmlcompman{}
	me.rootobj = rootobj
	robj := rootobj

	xobj := robj.FindChild("Aboutuiqml")
	// log.Println(aboutobj)
	me.aboutobj = xobj

	xobj = robj.FindChild("mainui.stb.msgcntlb")
	me.stbmsgcntlb = xobj

	xobj = robj.FindChild("mainui.stb.grpcntlb")
	me.stbgrpcntlb = xobj

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
	log.Println(goobj)
	log.Println(goobj.RowCount())
	me.msglstmdlco = xobj
	me.msglstmdl = goobj

	xobj = robj.FindChild("stackwin")
	me.stkwin = xobj
	gopp.Info(xobj, "stackwin?")
	me.stkitems = append(me.stkitems, me.aboutobj, me.aboutobj, me.aboutobj, me.aboutobj)
	log.Println(me)
	return me
}
