package com.archinamon.grooid

import android.widget.Toast
import com.archinamon.example.R

class Example {

    def static sendToast(def ctx) {
        Toast.makeText(ctx, ctx.getString(R.string.something_happend_groovy), Toast.LENGTH_LONG).show()
    }
}