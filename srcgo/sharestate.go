package main

var sss = &sharestate{}

type sharestate struct {
	olnchkerrmsg string
	olnchkerrcnt int

	netuplen int
	netdllen int
}
