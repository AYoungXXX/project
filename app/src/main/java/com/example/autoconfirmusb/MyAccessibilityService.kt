package com.example.autoconfirmusb

import android.accessibilityservice.AccessibilityService
import android.view.accessibility.AccessibilityEvent
import android.view.accessibility.AccessibilityNodeInfo.*
import android.widget.Toast

class MyAccessibilityService : AccessibilityService() {
    override fun onAccessibilityEvent(p0: AccessibilityEvent?) {
        val source = p0?.source ?: return

            for (i in 0 until source.childCount) {
//                source.getChild()
//                Toast.makeText(baseContext,"${source.getChild(i)?.text} ${source.packageName} ${source.findAccessibilityNodeInfosByText("传输文件").size}",Toast.LENGTH_SHORT).show()
                if (source.getChild(i)?.text?.contains("一律允许") == true) {
                    source.getChild(i).performAction(ACTION_CLICK)
                    source.findAccessibilityNodeInfosByText("允许").get(2).performAction(ACTION_CLICK)
                    Toast.makeText(
                        baseContext,
                        "收到事件${source.findAccessibilityNodeInfosByText("允许").size}:${p0.eventType.let { AccessibilityEvent.obtain(it) }}",
                        Toast.LENGTH_LONG
                    ).show()
                }
                if (source.getChild(i)?.text?.contains("USB 用于") == true) {
                    if(source.findAccessibilityNodeInfosByText("传输文件").size>0){
                        source.findAccessibilityNodeInfosByText("传输文件").first().parent.performAction(
                            ACTION_CLICK)
                    }
                }
            }

//        }
        source.recycle()
    }

    override fun onInterrupt() {
    }
}