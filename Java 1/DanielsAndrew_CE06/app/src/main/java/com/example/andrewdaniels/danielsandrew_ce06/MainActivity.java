package com.example.andrewdaniels.danielsandrew_ce06;

// Andrew Daniels
// JAV1 - C201805
// MainActivity.java

import android.os.AsyncTask;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

import java.text.DecimalFormat;

import android.view.View;
import android.widget.*;

public class MainActivity extends AppCompatActivity {

    private Button startBtn;
    private Button stopBtn;
    private TextView minutesTextField;
    private TextView secondsTextField;
    private CustomAsyncTimer timer;
    private Long numberOfMillisForTimer;



    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        startBtn = findViewById(R.id.startBtn);
        stopBtn = findViewById(R.id.stopBtn);

        minutesTextField = findViewById(R.id.minutesTextField);
        secondsTextField = findViewById(R.id.secondsTextField);

        startBtn.setOnClickListener(startButtonClicked);
        stopBtn.setOnClickListener(stopButtonClicked);

    }

    //Starts the timer when start button is clicked.
    private final Button.OnClickListener startButtonClicked = new Button.OnClickListener() {
        @Override
        public void onClick(View v) {
            if (!checkForEmptyTextViews()) {
                formatTextViews();
                Long startTimeInMillis = System.currentTimeMillis();
                timer = new CustomAsyncTimer();
                timer.execute(numberOfMillisForTimer, startTimeInMillis);
                startBtn.setEnabled(false);
                stopBtn.setEnabled(true);
            } else {
                //Create toast for filling out all fields.
                Toast.makeText(MainActivity.this, R.string.invalid_time, Toast.LENGTH_SHORT).show();
            }
        }
    };
    //Stops the timer when stop button is clicked.
    private final Button.OnClickListener stopButtonClicked = new Button.OnClickListener() {
        @Override
        public void onClick(View v) {
            timer.cancel(true);
        }
    };

    //Function that checks if any TextViews are empty or have value <= 0.
    private Boolean checkForEmptyTextViews() {
        return (minutesTextField.getText().toString().trim().equals("")
                || secondsTextField.getText().toString().trim().equals("")
                || (Integer.parseInt(minutesTextField.getText().toString()) <= 0
                && Integer.parseInt(secondsTextField.getText().toString()) <= 0)
        );
    }

    //This function will properly format the minutes and seconds TextViews.
    private void formatTextViews() {
        Double minutesUnformatted = Double.parseDouble(minutesTextField.getText().toString());
        Double secondsUnformatted = Double.parseDouble(secondsTextField.getText().toString());

        Double secondsFormatted = secondsUnformatted % 60;
        Double secondsConvertedToMinutes = (Math.floor(secondsUnformatted / 60));
        Double minutesFormatted = minutesUnformatted + secondsConvertedToMinutes.intValue();

        DecimalFormat formatter = new DecimalFormat("00");

        minutesTextField.setText(formatter.format(minutesFormatted));
        secondsTextField.setText(formatter.format(secondsFormatted));

        numberOfMillisForTimer = (Long.parseLong(formatter.format(minutesFormatted)) * 60 * 1000) + (Long.parseLong(formatter.format(secondsFormatted)) * 1000);

    }

    //This function will calculate the TextView's new value as time goes on.
    private String[] calculateTimeRemaining(long startTime, long currentTime, long timeToFinish) {
        long timeElapsed = currentTime - startTime;
        long timeRemaining = timeToFinish - timeElapsed;
        Double roundedMinutesRemaining = Math.ceil(timeRemaining / 1000 / 60);
        Double roundedSecondsRemaining = Math.ceil((timeRemaining / 1000) % 60);
        Integer minutesRemaining = roundedMinutesRemaining.intValue();
        Integer secondsRemaining = roundedSecondsRemaining.intValue();
        DecimalFormat formatter = new DecimalFormat("00");

        return new String[] {formatter.format(minutesRemaining), formatter.format(secondsRemaining)};
    }

    //This function returns the minutes and seconds remaining from the milliseconds format from TimeElapsed.
    private String[] parseTimeElapsed(long timeElapsed) {
        Double roundedMinutesRemaining = Math.floor(timeElapsed / 1000 / 60);
        Double roundedSecondsRemaining = Math.floor((timeElapsed/ 1000) % 60);
        Integer minutesRemaining = roundedMinutesRemaining.intValue();
        Integer secondsRemaining = roundedSecondsRemaining.intValue();
        DecimalFormat formatter = new DecimalFormat("00");

        return new String[] {formatter.format(minutesRemaining), formatter.format(secondsRemaining)};
    }

    //This Class runs an a timer function in a separate thread.
    private class CustomAsyncTimer extends AsyncTask<Long, String, String> {
        Long startTimeInMillis;

        //Let user know the timer has started
        @Override
        protected void onPreExecute() {
            super.onPreExecute();
            Toast.makeText(MainActivity.this, R.string.timer_started, Toast.LENGTH_SHORT).show();
        }

        //Let user know the timer has expired
        //ReEnable start button and disable stop button
        @Override
        protected void onPostExecute(String s) {
            super.onPostExecute(s);
            AlertDialog.Builder timerExpired = new AlertDialog.Builder(MainActivity.this);
            timerExpired.setTitle(R.string.alert_dialog_title);
            timerExpired.setMessage("Timer expired.");
            timerExpired.setPositiveButton("OK", null);
            timerExpired.show();
            startBtn.setEnabled(true);
            stopBtn.setEnabled(false);
        }

        //Update UI TextFields as timer counts down.
        @Override
        protected void onProgressUpdate(String... values) {
            super.onProgressUpdate(values);
            minutesTextField.setText(values[0]);
            secondsTextField.setText(values[1]);
        }

        //Let user know how much time has elapsed when they cancel timer.
        @Override
        protected void onCancelled() {
            super.onCancelled();
            Long currentTimeInMillis = System.currentTimeMillis();
            Long timeElapsed = currentTimeInMillis - startTimeInMillis;

            String[] secAndMinElapsed = parseTimeElapsed(timeElapsed);

            secondsTextField.setText(R.string.reset_timer);
            minutesTextField.setText(R.string.reset_timer);
            AlertDialog.Builder timerCancelled = new AlertDialog.Builder(MainActivity.this);
            timerCancelled.setTitle(R.string.alert_dialog_title);
            timerCancelled.setMessage("Timer cancelled. Time elapsed: " + secAndMinElapsed[0] + ':' + secAndMinElapsed[1]);
            timerCancelled.setPositiveButton("OK", null);
            timerCancelled.show();
            startBtn.setEnabled(true);
            stopBtn.setEnabled(false);
        }

        //This method handles the work done in the separate thread.
        //The works consists of counting down from the time the user started the timer at.
        @Override
        protected String doInBackground(Long... longs) {
            Long timeTillComplete = longs[0];
            startTimeInMillis = longs[1];
            Long currentTimeInMillis = System.currentTimeMillis();
            while (currentTimeInMillis - startTimeInMillis < timeTillComplete) {
                try {
                    Thread.sleep(200);
                    if (isCancelled()) {
                        return null;
                    }
                    currentTimeInMillis = System.currentTimeMillis();
                    publishProgress(calculateTimeRemaining(startTimeInMillis, currentTimeInMillis, timeTillComplete));
                }
                catch (java.lang.InterruptedException e) {
                    e.printStackTrace();
                }
            }
            return null;

        }
    }

}
