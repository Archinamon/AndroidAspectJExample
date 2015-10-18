package com.archinamon.example.xpoint;

import android.app.NotificationManager;
import android.content.Context;
import android.support.v7.app.NotificationCompat;
import android.view.View;
import android.widget.TextView;
import com.archinamon.example.MainActivity;
import com.archinamon.example.R;

/**
 * Created by Archinamon on 10/6/15.
 */
aspect EventRepeater {

    private static int sMagic = 3;

    pointcut event(): execution(* MainActivity.on*Clicked(View));

    after() returning: event() {
        final Context ctx = (Context) thisJoinPoint.getTarget();
        final TextView argument = (TextView) thisJoinPoint.getArgs()[0];

        NotificationManager nm = (NotificationManager) ctx.getSystemService(Context.NOTIFICATION_SERVICE);
        nm.notify(sMagic++ << 1,
                  new NotificationCompat.Builder(ctx).setSmallIcon(R.mipmap.ic_launcher)
                                                     .setContentTitle("Something happend!")
                                                     .setContentText(argument.getText() + " clicked!")
                                                     .build());
    }
}
