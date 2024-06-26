package main

/*

 */
import "C"
import (
	"encoding/json"
	"log"
	"sync/atomic"
	"time"

	spjson "github.com/bitly/go-simplejson"
	"github.com/envsh/fedind/guiclish"
	"github.com/kitech/gopp"
	"github.com/kitech/gopp/cgopp"
	"github.com/kitech/minqt"
)

//export qmlcalljsfunc
func qmlcalljsfunc(jstr voidptr, jstrlen usize, retaddr *charptr, retlen *usize) {
	// log.Println(jstr, jstrlen)
	qmlcalljsfuncimpl(cgopp.GoStringN(jstr, jstrlen), retaddr, retlen)
}

func qmlcalljsfuncimpl(jstr string, retaddr *charptr, retlen *usize) {
	log.Println(len(jstr), jstr)

	if false {
		res, ok := asyncInvokeProcessor(jstr)
		if false && ok {
			*retaddr = (charptr)(cgopp.CStringaf(res))
			*retlen = usize(len(res))
			*retaddr = nil
			*retlen = 0
		}
	}

	qcnr.enqueue(jstr)

	*retlen = 0
	*retaddr = nil
}

// ////////////
// 使用最多一个runner goroutine
// 在没有任务的时候退出,有任务的时候启动,但不会同时启动多个
var qcnr = qmlcalljsrunnernew()

func qmlcalljsrunnernew() *qmlcalljsrunner {
	me := &qmlcalljsrunner{}
	me.qc = make(chan string, 286)

	return me
}

type qmlcalljsrunner struct {
	qc      chan string
	running int32
	runcnt  int32
}

func (me *qmlcalljsrunner) enqueue(jstr string) {
	me.qc <- jstr
	if atomic.LoadInt32(&me.running) == 0 {
		go me.start()
	}
}

func (me *qmlcalljsrunner) start() {
	runcnt := atomic.AddInt32(&me.running, 1)
	defer atomic.AddInt32(&me.running, -1)
	if runcnt != 1 {
		gopp.Warn("duprun", runcnt, me.runcnt)
		return
	}
	atomic.AddInt32(&me.runcnt, 1)
	qmlcalljsproc(me.qc)
}

func qmlcalljsproc(qc chan string) {
	for {
		select {
		case jstr, ok := <-qc:
			if !ok {
				goto endfor
			}
			asyncInvokeProcessor(jstr)
		}
	}
endfor:
}

func asyncInvokeProcessor(reqdata string) (string, bool) {
	// log.Println("reqdata txt", reqdata, nowtimerfc3389())

	cio, err := Invokecmdparse(reqdata)
	gopp.ErrPrint(err, reqdata)
	if err != nil {
		return gopp.JsonMarshalMust(&guiclish.Cmdinfo{Errmsg: err.Error()}), true
	}
	cmdrun(cio)

	cio.Retc = len(cio.Retv)
	resp, err := json.Marshal(cio)
	gopp.ErrPrint(err, cio)
	if cio.Retful() {
		log.Println("resp ready", len(resp), gopp.SubStr(string(resp), 66))
	}
	// v.resp = C.CString(string(resp))
	// v.len2 = usize(len(resp))
	return string(resp), cio.Retful()

	// log.Println("respobj", v)
}

func Invokecmdparse(jstr string) (*guiclish.Cmdinfo, error) {
	var data = jstr

	// data := C.GoStringN(prm.ptr, C.int(prm.len))
	jso, err := spjson.NewJson([]byte(data))
	gopp.ErrPrint(err, jstr, jso != nil)
	if err != nil {
		return nil, err
	}

	// log.Println(jso.Get("cmd"), jso.Get("argc"), jso.Get("argv"))
	// log.Println(jso)
	cio := &guiclish.Cmdinfo{}
	err = json.Unmarshal([]byte(data), cio)
	gopp.ErrPrint(err, jstr)
	// log.Println(cio)
	return cio, err
}
func cmdrun(cio *guiclish.Cmdinfo) {
	// log.Println(cio.Cmd)
	var nowt = time.Now()
	_ = nowt
	switch cio.Cmd {
	case "switchpageidx":
		minqt.RunonUithread(func() {
			mainui.switchpageidx(int(cio.Argv[0].(float64)))
		})
	case "switchpage":
		minqt.RunonUithread(func() {
			mainui.switchpage(cio.Argv[0].(bool))
		})
	case "msglst.scrollvto":
		minqt.RunonUithread(func() {
			msglstwin.Scrollvto(cio.Argv[0].(bool))
		})
	case "msglst.setccfmt":
		minqt.RunonUithread(func() {
			msglstwin.Setccfmt(int(cio.Argv[0].(float64)))
		})
	case "msglst.sendmsg":
		msglstwin.Sendmsg()
	case "loadmsg":
		mainui.onloadmsg()

	case "fetchmore":

	case "fetchmorert":
		msglder := guiclish.Msglder()
		err := msglder.More(cio.Argv[0].(string))
		gopp.ErrPrint(err)
		if err != nil {
			cio.Errmsg = err.Error()
		}
		minqt.RunonUithread(mainui.upstatusmc)
	case "loginaccountline":
		objx := qmlcpm.rootobj.FindChild("acclst")
		curvalx := objx.Property("currentValue")
		// log.Println(curvalx)
		if curvalx.Cthis == nil {
			gopp.Warn("cannot get account")
			break
		}
		rv := curvalx.Tostr()
		log.Println(rv)
		ok := guiclish.OnFrontuiLoginAccountline(rv)
		gopp.FalsePrint(ok, "login failed", rv)
		if ok {
			minqt.RunonUithread(func() {
				mainui.switchpageidx(0)
			})
		}
	default:
		gopp.Warn(cio.Cmd, cio.Argv)
	}

}
