package com.archinamon.kotlin

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.support.design.widget.FloatingActionButton
import android.support.v7.app.AppCompatActivity
import android.support.v7.widget.Toolbar
import com.archinamon.example.R
import com.archinamon.example.profiler.ProfileDynamic

@ProfileDynamic
class InfoActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_info)
        val toolbar = findViewById(R.id.toolbar) as Toolbar
        setSupportActionBar(toolbar)

        val fab = findViewById(R.id.fab) as FloatingActionButton
        fab.setOnClickListener({ view ->
            val uri = "mailto:archinamon@gmail.com" +
                "?subject=" + Uri.encode("Example project feedback")
            val intent = Intent(Intent.ACTION_SENDTO).setData(Uri.parse(uri))
            startActivity(Intent.createChooser(intent, "Send email feedback"))
        })
        supportActionBar!!.setDisplayHomeAsUpEnabled(true)
    }

}