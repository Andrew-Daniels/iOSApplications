package com.example.andrewdaniels.danielsandrew_ce07;


// Andrew Daniels
// JAV1 - C201805
// MainActivity.java

import android.content.Context;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.AsyncTask;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.GridView;
import android.widget.ProgressBar;
import android.widget.Toast;

import org.apache.commons.io.IOUtils;
import org.json.JSONArray;
import org.json.JSONObject;


import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;


public class MainActivity extends AppCompatActivity {

    private final ArrayList<GoogleBooks> favoriteGoogleBooks = new ArrayList<>();
    private GridView mGridView;
    private ProgressBar progressBar;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        mGridView = findViewById(R.id.bookGridView);
        progressBar = findViewById(R.id.progressBar);

        if(CheckForNetworkStateAndPermissions()) {
            DataTask task = new DataTask();
            String apiKey = "AIzaSyC87rTzWBO8dbTroAf2pq7Zb90cWFn4kPE";
            String favoriteBooks = "https://www.googleapis.com/books/v1/users/117524763747741622983/bookshelves/0/volumes?key=" + apiKey;
            task.execute(favoriteBooks);
        } else {
            progressBar.setVisibility(View.GONE);
            Toast.makeText(MainActivity.this, R.string.no_connection, Toast.LENGTH_SHORT).show();
        }


    }

    //This method checks for an internet connection
    private boolean CheckForNetworkStateAndPermissions(){
        ConnectivityManager mgr = (ConnectivityManager) getSystemService(Context.CONNECTIVITY_SERVICE);
        if(mgr != null) {
            NetworkInfo[] info = mgr.getAllNetworkInfo();
            if (info != null) {
                for (NetworkInfo connectionInfo: info) {
                    switch (connectionInfo.getTypeName()) {
                        case "WIFI":
                            if (connectionInfo.isConnected()) {
                                return true;
                            }
                            break;
                        case "MOBILE":
                            if (connectionInfo.isConnected()) {
                                return true;
                            }
                            break;
                    }
                }
            }
        }
        return false;
    }

    //This method returns the GoogleBook data from Google Books API
    private String getNetworkData(String urlString) {
        try {
            URL url = new URL(urlString);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.connect();

            InputStream is = conn.getInputStream();
            String data = IOUtils.toString(is, "UTF-8");
            is.close();

            conn.disconnect();

            return data;

        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    private class DataTask extends AsyncTask<String, Void, String> {


        //Grab the GoogleBook JSON Data for parsing.
        @Override
        protected String doInBackground(String... strings) {
            String favoriteBooksJSON;

            favoriteBooksJSON = getNetworkData(strings[0]);

            return favoriteBooksJSON;
        }

        //Display GoogleBooks on UI here
        @Override
        protected void onPostExecute(String s) {
            super.onPostExecute(s);
            //Here I need to parse the JSON Data
            ParseJSONBooksIntoBookObjects(s);
            GoogleBookAdapter bookAdapter = new GoogleBookAdapter(MainActivity.this, favoriteGoogleBooks, R.layout.gridview_googleapi_layout);
            mGridView.setAdapter(bookAdapter);
            progressBar.setVisibility(View.GONE);
        }

        //This method parses through all JSON data to create GoogleBooks objects
        private void ParseJSONBooksIntoBookObjects(String favoriteBooksAsJSON) {
            try {
                JSONObject outerMostObject = new JSONObject(favoriteBooksAsJSON);
                JSONArray allBooks = outerMostObject.getJSONArray("items");
                for (int i = 0; i < allBooks.length(); i ++) {
                    String title;
                    String coverImage;

                    JSONObject bookObject = allBooks.getJSONObject(i);
                    JSONObject volumeInfo = bookObject.getJSONObject("volumeInfo");
                    JSONObject imageLinks = volumeInfo.getJSONObject("imageLinks");

                    title = volumeInfo.getString("title");
                    coverImage = imageLinks.getString("smallThumbnail");
                    GoogleBooks newBook = new GoogleBooks(title, coverImage);

                    favoriteGoogleBooks.add(newBook);
                }
            } catch (org.json.JSONException e) {
                e.printStackTrace();
            }
        }
    }

}
