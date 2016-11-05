package com.archinamon.kotlin

import android.content.Context
import android.widget.Toast
import com.archinamon.example.R

/**
 * TODO: Add destription
 *
 * @author archinamon on 05/11/16.
 */
fun sendToast(ctx: Context) {
    Toast.makeText(ctx, ctx.getString(R.string.something_happend_kotlin), Toast.LENGTH_LONG).show()
}