package main

import (
	"strings"

	"github.com/kitech/gopp"
	"github.com/kitech/minqt"
	_ "github.com/kitech/minqt"
)

func init() {
	minqt.OnMissingCall = missingCall
}
func missingCall(callee string) {
	gopp.Debug(callee)

	switch callee {
	case "neslot1":
	default:
		const pfx1 = "switchpageidx_"
		if strings.HasPrefix(callee, pfx1) {
			// switchpageidx(callee[len(pfx1):])
		}
	}
}
