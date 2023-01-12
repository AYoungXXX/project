package com.example.composeuiapp

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.viewModels
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.material.*
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.livedata.observeAsState
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.style.TextDecoration
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.composeuiapp.ui.theme.ComposeUiAppTheme

class MainActivity : ComponentActivity() {
    private val viewModel: MainViewModel by viewModels()
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            ComposeUiAppTheme {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colors.background
                ) {
                    Scaffold(
                        topBar = {
                            TopAppBar {
                                Text(text = "我的compose应用")
                            }
                        },
                        floatingActionButton = {
                            Button(
                                onClick = {

                                },
                            ) {
                                Text(text = "+")
                            }
                        }

                    ) {
//                        val count by viewModel.index.
                        val n = viewModel.index.observeAsState(0)
                        Column {
//                            mutableStateOf()
                            Greeting("Android", count = n.value) {
                                viewModel.onIndexChange(viewModel.index.value!! + 1)
                            }
                        }
                    }
                }
            }
        }
    }
}

@Composable
fun Greeting(name: String, count: Int, onClick: () -> Unit) {

    LazyColumn(content = {

//        items()
    })
    Column(horizontalAlignment = Alignment.CenterHorizontally) {
        Text(text = "Hello $name!")
        Text(text = "$count", style = TextStyle(fontSize = 18.sp, color = Color.Green))
        Button(onClick = {
            onClick()
        }) {
            Text(text = "点击")
        }

    }
}

@Preview(showBackground = true)
@Composable
fun DefaultPreview() {
    ComposeUiAppTheme {
        Greeting("World", 1) {}
    }
}

@Preview(showBackground = true, widthDp = 180, heightDp = 240)
@Composable
fun TextPreview() {
    return HelloText()
}

@Composable
fun HelloText() {
    return Column (horizontalAlignment = Alignment.CenterHorizontally){
        Text(
            text = "Hello World!",
            style = TextStyle(fontSize = 11.sp),
            textDecoration = TextDecoration.None
        )
        Text(
            text = "Hello World!",
            style = TextStyle(fontSize = 11.sp),
            textDecoration = TextDecoration.LineThrough
        )
        Text(
            text = "Hello World!",
            style = TextStyle(fontSize = 11.sp),
            textDecoration = TextDecoration.Underline
        )
    }
}

