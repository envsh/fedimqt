package main

import (
	"log"

	"github.com/envsh/fedind/guiclish"
)

func init() {
	guiclish.SetUiappCbfn(onuiappcb)
}

func onuiappcb(cio *guiclish.Cmdinfo) {
	log.Println(cio.Cmd, cio.Argv, cio.Retv)
}
