package main

import (
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
	}
}
