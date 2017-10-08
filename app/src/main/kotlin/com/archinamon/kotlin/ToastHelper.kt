package com.archinamon.kotlin

import android.content.Context
import android.widget.Toast
import com.archinamon.libinstantparcelable.parcel.Parcelable

fun sendToast(ctx: Context, info: TextInfo) {
    Toast.makeText(ctx, info.text, Toast.LENGTH_LONG).show()
}

data @Parcelable class TextInfo(val text: String = "")