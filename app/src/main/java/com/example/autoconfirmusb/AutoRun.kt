package com.example.autoconfirmusb

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent

class AutoRun : BroadcastReceiver() {


    override fun onReceive(context: Context?, intent: Intent?) {
        if (intent?.action.equals("android.intent.action.BOOT_COMPLETED")) {
            val intent: Intent = Intent()
            intent.setClass(context!!, MyAccessibilityService::class.java)// 开机后指定要执行程序的界面文件
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            context.startService(intent)
        }
    }
}