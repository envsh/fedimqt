

import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts


// Rectangle {}
// Text 
// Button
// QtObject { }

// see https://www.basyskom.de/en/2020/how-to-speedup-your-qt-qml-lists/


Item {
        id: elementCache

        visible: false

        property var delegateCache: []

        function getDelegate() {
            console.log("getDelegate, cache size", delegateCache.length)
            if (delegateCache.length > 0)
            {
                return delegateCache.pop()
            }
            else
            {
                return delegateComponent.createObject(elementCache)
            }
        }

        function returnDelegate( item ) {
            console.log("returnDelegate", item, "size", delegateCache.length)
            
            item.parent = elementCache
        
            /* 
                reset all properties of the delegate 
                this is important to get rid of bindings
                if you dont do this, you may experience crashes
                
                i.e.
                
                item.myProperty = ""
                item.myBindedProperty = false
            */
            item.anchors.fill = elementCache
            item.name = ""
            item.aStaticProperty = false

            delegateCache.push( item )
        }

        Component.onCompleted: {
            for (var i = 0; i < 10; ++i)
            {
                var element = delegateComponent.createObject(elementCache)
                delegateCache.push(element)
            }
        }

        Component {
            id: delegateComponent

            MyComplexDelegate {}
        }
    } 