package com.archinamon.example;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;
import java.util.Locale;

public class MainActivity extends AppCompatActivity {

    private TextView mHelloField;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        mHelloField = (TextView) findViewById(R.id.hello_world);
    }

    @Override
    protected void onStart() {
        super.onStart();

        final MyApplication app = (MyApplication) getApplication();
        final String lang = app.getPreferences()
                               .getString(MyApplication.LANG_KEY,
                                          Locale.getDefault().getDisplayLanguage());

        if (mHelloField != null) {
            mHelloField.append("\n");
            mHelloField.append(getString(R.string.running));
            mHelloField.append(" ");
            mHelloField.append(lang);
            mHelloField.append("!");
        }
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }

    public void onFirstButtonClicked(View view) {
        toast();
    }

    public void onSecondButtonClicked(View view) {
        toast();
    }

    public void onThirdButtonClicked(View view) {
        toast();
    }

    private void toast() {
        Toast.makeText(this, getString(R.string.something_happend), Toast.LENGTH_LONG).show();
    }
}
