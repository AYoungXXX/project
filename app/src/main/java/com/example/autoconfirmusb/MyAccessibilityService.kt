package com.example.autoconfirmusb

import android.accessibilityservice.AccessibilityService
import android.view.accessibility.AccessibilityEvent
import android.view.accessibility.AccessibilityNodeInfo.ACTION_CLICK
import android.widget.Toast

class MyAccessibilityService : AccessibilityService() {
    override fun onAccessibilityEvent(p0: AccessibilityEvent?) {
        val source = p0?.source ?: return
//        Toast.makeText(baseContext, "${p0.source.text}", Toast.LENGTH_SHORT).show()
//        if(p0.eventType == AccessibilityEvent.TYPE_WINDOW_CONTENT_CHANGED ){
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
            }

//        }
        source.recycle()
    }

    override fun onInterrupt() {
    }
}