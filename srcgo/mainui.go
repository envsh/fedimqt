package main

import (
	"fmt"
	"log"
	"time"

	"github.com/envsh/fedind/guiclish"
	"github.com/kitech/gopp"
	"github.com/kitech/minqt"
)

var mainui = &mainuist{}

type mainuist struct {
	stkcuridx int
}

func (me *mainuist) uptimesetuit() {
	minqt.RunonUithread(me.uptimeset)
}
func (me *mainuist) uptimeset() {

	tm1 := gopp.TimeToFmt1(gopp.StartTime)
	dur := time.Since(gopp.StartTime)
	txt := fmt.Sprintf("%v", gopp.Dur2hum(dur))
	// btime := time.Now()
	// Updates can only be scheduled from GUI thread or from QQuickItem::updatePaintNode()

	qmlcpm.stbuptimelb.SetProperty("text", txt)
	qmlcpm.stbuptimelb.SetProperty("tiptext", txt+" "+tm1)

	// qmlcpm.stbuptimelb.Property("tiptext")
	// qmlcpm.stbuptimelb.Property("text")

	// log.Println(time.Since(btime)) // 竟然有1-2ms!!!

}

func (me *mainuist) onloadmsg() {
	cond := "1=1 limit 300"
	locdb := guiclish.Locdb()
	recs, err := locdb.Loadmsgs(cond)
	gopp.ErrPrint(err, cond)
	addcnt := 0
	for _, rec := range recs {
		added := onmtxevtcb(nil, rec, false)
		addcnt += gopp.IfElse2(added, 1, 0)
	}
	gopp.Println("addcnt/total", addcnt, len(recs))

	msglstwin.Scrollvto(true)

	minqt.RunonUithread(me.upstatusmc)

	/*
		cio.Retful = true
		cond := cio.Argv[0].(string)
		locdb := Locdb()
		recs, err := locdb.Loadmsgs(cond)
		gopp.ErrPrint(err, cond)
		for i, rec := range recs {
			// bcc, err := json.Marshal(rec)
			// gopp.ErrPrint(err, i)
			// cio.Retv = append(cio.Retv, string(bcc))
			cio.Retv = append(cio.Retv, rec)
			gopp.GOUSED(i)
		}
	*/
	/*
		let req = Tspp.tojson({Cmd: "loadmsg", Argv:["1=1 limit 300"]});
		let resp = qcffi.invoke(req);
	*/
}

func (me *mainuist) upstatusmc() {
	cnt := qmlcpm.msglstmdl.RowCount()
	qmlcpm.stbmsgcntlb.SetProperty("text", fmt.Sprintf("MC: %d", cnt))
}

func (me *mainuist) upstatusrc() {
	cnt := qmlcpm.grplstmdl.RowCount()
	qmlcpm.stbgrpcntlb.SetProperty("text", fmt.Sprintf("RC: %d", cnt))
}

func (me *mainuist) upstatuscp() {
	qmlcpm.stbcurwinlb.SetProperty("text", fmt.Sprintf("CP: P%d", me.stkcuridx))
}

/*
   function upstatusrc(cnt) {
       grpcntst.text = 'RC:'+cnt;
   }
   function upstatuscp(pagename) {
       curwinst.text = 'CP:'+pagename;
   }
*/

func (me *mainuist) onolnchkerr(msg string) string {
	if msg == sss.olnchkerrmsg {
		sss.olnchkerrcnt++
	} else {
		sss.olnchkerrmsg = msg
		sss.olnchkerrcnt = 1
	}

	ret := fmt.Sprintf("%d %s", sss.olnchkerrcnt, msg)
	// me.upstatusll(ret)
	return ret
	/*
	   let msg = Argv[1];
	   if (msg == Sss.olnchkerrmsg) {
	       Sss.olnchkerrcnt += 1;
	   }else{
	       Sss.olnchkerrmsg = msg;
	       Sss.olnchkerrcnt = 1;
	   }
	   // upstatusll(msg + ' ' + Sss.olnchkerrcnt);
	   // Tspp.debug(msg, Sss.olnchkerrcnt);
	   let ret = msg + ' ' + Sss.olnchkerrcnt;
	   return ret;
	*/

}

func (me *mainuist) onnetreqnote(begin bool, len int) {
	if begin {
		sss.netuplen += len
	} else {
		sss.netdllen += len
	}

	minqt.RunonUithread(func() {
		me.upnetreqst(begin)
	})
}
func (me *mainuist) onnetstatus(online bool, errmsg string) {
	// gopp.Println(online, errmsg)
	stmsg := me.onolnchkerr(errmsg)

	minqt.RunonUithread(func() {
		me.upstatusll(stmsg)

		tiptxt := gopp.IfElse2(errmsg != "", "Ok", errmsg) + " " + gopp.TimeToFmt1Now()
		obj := qmlcpm.rootobj.FindChild("onlinest")
		obj.SetProperty("tiptext", tiptxt)
	})
	/*
	   let online = jso.Argv[0];
	   // onlinest.icon.source = online?"icons/online_2x.png":"icons/offline_2x.png";
	   onlinest.icon.color = online?"darkgreen":""
	   let tmstr = Tspp.nowtmstrzh();
	   onlinest.tiptext = (jso.Argv[1]==''?"Ok" : jso.Argv[1]) + ': ' + tmstr;
	*/
}

func (me *mainuist) upstatusll(stlog string) {
	// obj := qmlcpm.rootobj.FindChild("mainui.stb.lastloglb")
	obj := qmlcpm.stblastloglb
	obj.SetProperty("text", "LL:"+stlog)
	stlog = stlog + ", " + gopp.TimeToFmt1Now()
	obj.SetProperty("tiptext", "LL:"+stlog)
	// lastlogst.text = 'LL:'+lastlog;
	// lastlogst.tiptext = 'LL:'+lastlog;
}

func (me *mainuist) upnetreqst(begin bool) {
	txt := fmt.Sprintf("UP: %d, DL: %d, TM: %s",
		sss.netuplen, sss.netdllen, gopp.TimeToFmt1Now())
	obj := qmlcpm.rootobj.FindChild("netreqstnorm")
	obj.SetProperty("tiptext", txt)
	obj.SetProperty("visible", !begin)
	{
		obj := qmlcpm.rootobj.FindChild("netreqstloading")
		obj.SetProperty("visible", begin)
		obj.SetProperty("paused", !begin)
	}
	// gopp.Info(begin, txt)
}

func (me *mainuist) switchpage(prev bool) {
	// const pcnt = 5 // todo auto get the value
	var pcnt = len(qmlcpm.stkitems)
	// stkw := qmlcpm.stkwin
	// curidx := stkw.Property("curidx").Toint()
	curidx := me.stkcuridx

	nxtidx := curidx + gopp.IfElse2(prev, -1, 1)
	if nxtidx < 0 {
		nxtidx = pcnt - 1
	} else if nxtidx >= pcnt {
		nxtidx = 0
	}

	// log.Println(curidx, nxtidx)
	{
		// me.stkcuridx = nxtidx
		// guiclish.EmitEventFront("switchpageidx", nxtidx)
	}
	minqt.RunonUithread(func() { me.switchpageidx(nxtidx) })
}

// todooooo
func (me *mainuist) switchpageidx(idx int) {
	// gopp.Info(idx)
	// stkw := qmlcpm.rootobj.FindChild("stackwin")
	// gopp.Info(stkw)
	// vx := obj.Property("currentItem")
	// defer vx.Dtor()
	// gopp.Info(vx)
	// gopp.Info(vx.Toptr())
	// curritemx := vx.Toptr() // QQuickItem*
	nxtidx := idx
	nextitem := qmlcpm.stkitems[nxtidx] // todo not complete, crash
	stkwin := minqt.QStackViewof(qmlcpm.stkwin.Cthis)
	// qmlcpm.stkwin.Replace(curritemx, nextitem)
	// stkwin.Replace(minqt.QQuickItemof(curritemx), minqt.QQuickItemof(nextitem.Cthis))
	olditem := stkwin.ReplaceCurrentItem(minqt.QQuickItemof(nextitem.Cthis))
	log.Println(olditem, me.stkcuridx, "=>", idx)
	// stkw.SetProperty("curidx", idx)
	me.stkcuridx = idx

	/*
	   let stkwin = stackwin;
	   let curitem = stkwin.currentItem;
	   let nxtidx = idx;
	   let nxtitem = stkwin.childs[nxtidx];
	   stkwin.curidx = nxtidx;
	   Tspp.debug(idx, "curitem", curitem, "nxtitem", nxtitem);
	   stkwin.replace(curitem, nxtitem);
	*/
}
