package com.example.composeuiapp

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel

class MainViewModel : ViewModel() {
    private val _index = MutableLiveData(5)
    val index:LiveData<Int> = _index

    fun onIndexChange(newIndex:Int){
        _index.value = newIndex
    }
}