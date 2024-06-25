package main

/*

 */
import "C"
import (
	"encoding/json"
	"log"
	"time"

	spjson "github.com/bitly/go-simplejson"
	"github.com/envsh/fedind/guiclish"
	"github.com/kitech/gopp"
	"github.com/kitech/gopp/cgopp"
)

//export qmlcalljsfunc
func qmlcalljsfunc(jstr voidptr, jstrlen usize, retaddr *charptr, retlen *usize) {
	// log.Println(jstr, jstrlen)
	qmlcalljsfuncimpl(cgopp.GoStringN(jstr, jstrlen), retaddr, retlen)
}

func qmlcalljsfuncimpl(jstr string, retaddr *charptr, retlen *usize) {
	log.Println(len(jstr), jstr)
	res, ok := asyncInvokeProcessor(jstr)
	if ok {
		*retaddr = (charptr)(cgopp.CStringaf(res))
		*retlen = usize(len(res))
		*retaddr = nil
		*retlen = 0
	}
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
	if cio.Retful {
		log.Println("resp ready", len(resp), gopp.SubStr(string(resp), 66))
	}
	// v.resp = C.CString(string(resp))
	// v.len2 = usize(len(resp))
	return string(resp), cio.Retful

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
		mainui.switchpageidx(int(cio.Argv[0].(float64)))
	case "switchpage":
		mainui.switchpage(cio.Argv[0].(bool))
	case "msglst.scrollvto":
		msglstwin.Scrollvto(cio.Argv[0].(bool))
	case "msglst.setccfmt":
		msglstwin.Setccfmt(int(cio.Argv[0].(float64)))
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
	}
}
