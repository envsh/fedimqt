package main

import (
	"log"
	"reflect"
	"unsafe"
	// _ "github.com/goccy/go-reflect"
	// "github.com/goccy/go-reflect"
	// _ "github.com/viant/xunsafe"
)

type GoabiType struct {
	Size_       uintptr
	PtrBytes    uintptr // number of (prefix) bytes in the type that can contain pointers
	Hash        uint32  // hash of type; avoids computation in hash tables
	TFlag       uint8   // TFlag   // extra type information flags
	Align_      uint8   // alignment of variable with this type
	FieldAlign_ uint8   // alignment of struct field with this type
	Kind_       uint8   // enumeration for C
	// function for comparing objects of this type
	// (ptr to object A, ptr to object B) -> ==?
	Equal func(unsafe.Pointer, unsafe.Pointer) bool
	// GCData stores the GC type data for the garbage collector.
	// If the KindGCProg bit is set in kind, GCData is a GC program.
	// Otherwise it is a ptrmask bitmap. See mbitmap.go for details.
	GCData    *byte
	Str       int32 // NameOff // string form
	PtrToThis int32 // TypeOff // type for pointer to this type, may be zero
}

type GorefValue struct {
	// Typ  *abi.Type
	Typ  *GoabiType
	Ptr  voidptr
	Flag usize
}

// for unexport
func (me *GorefValue) UnsetRO() {
	me.Flag = me.Flag ^ uintptr(flagRO)
}
func GorefValueUnsetRO(v *reflect.Value) {
	v2 := (*GorefValue)(voidptr(v))
	v2.UnsetRO()
}

type GorefFlag uintptr

const (
	flagKindWidth             = 5 // there are 27 kinds
	flagKindMask    GorefFlag = 1<<flagKindWidth - 1
	flagStickyRO    GorefFlag = 1 << 5
	flagEmbedRO     GorefFlag = 1 << 6
	flagIndir       GorefFlag = 1 << 7
	flagAddr        GorefFlag = 1 << 8
	flagMethod      GorefFlag = 1 << 9
	flagMethodShift           = 10
	flagRO          GorefFlag = flagStickyRO | flagEmbedRO
)

// todo how deal unexport field???
// 需要一个更强大的reflect库
func DeepSizeof(vx any, depth int) (rv int) {
	valx := reflect.ValueOf(vx)
	GorefValueUnsetRO(&valx)
	vty := reflect.TypeOf(vx)

	// log.Println(depth, vty.String(), vty.Size())
	switch vty.Kind() {
	case reflect.Pointer:
		e := valx.Elem().Interface()
		rv += DeepSizeof(e, depth+1)

	case reflect.Chan: // todo 不准确的
		elemtysz := valx.Elem().Type().Size()
		elemcnt := valx.Len()
		rv += elemcnt * int(elemtysz)

	case reflect.Struct:
		for i := 0; i < valx.NumField(); i++ {
			fvxy := valx.Field(i)
			if fvxy.CanInterface() {
				fvx := fvxy.Interface()
				rv += DeepSizeof(fvx, depth+1)
			} else {
				// grv := (*GorefValue)((voidptr)(&valx))
				log.Println("Cannot iface, unexported?", vty.String(), vty.Field(i).Name)
			}

		}
	case reflect.Slice, reflect.Array:
		for i := 0; i < valx.Len(); i++ {
			fvx := valx.Index(i).Interface()
			rv += DeepSizeof(fvx, depth+1)
		}
	case reflect.Map:
		keysx := valx.MapKeys()
		for _, keyx := range keysx {
			mvx := valx.MapIndex(keyx)
			rv += DeepSizeof(keyx.Interface(), depth+1)
			rv += DeepSizeof(mvx.Interface(), depth+1)
		}
	case reflect.String:
		rv += len(vx.(string))
	default:
		// rv += int(unsafe.Sizeof(vx))
	}
	rv += int(vty.Size())
	return
}
