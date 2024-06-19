package main

/*
// extern void qtemitcallqml(char*);
*/
import "C"
import (
	"log"

	"github.com/kitech/minqt"
)

var qmlape minqt.QQmlApplicationEngine
var qmlcpm *qmlcompman

// usage: in cpp
// first call, connect signal
// second call, run flow back

//export qmlappenginenew
func qmlappenginenew(step int) voidptr {
	switch step {
	case 0:
		e := minqt.QQmlApplicationEngineNew()
		qmlape = e
		return e.Cthis

	case 1:

	case 2:

	case 3:
		robj := qmlape.RootObject()
		qmlcpm = qmlcompmannew(robj)

	default:
		log.Println("not expect", step)
	}

	return nil
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

	log.Println(me)
	return me
}
