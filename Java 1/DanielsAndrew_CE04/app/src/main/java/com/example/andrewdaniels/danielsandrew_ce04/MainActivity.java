package com.example.andrewdaniels.danielsandrew_ce04;

// Andrew Daniels
// JAV1 - C201804
// MainActivity.java

import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.Gravity;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.GridView;
import android.widget.ListView;
import android.widget.SimpleAdapter;
import android.widget.Spinner;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.HashMap;

public class MainActivity extends AppCompatActivity {

    private ListView mListView;
    private GridView mGridView;
    private static final String TAG = "MainActivity";
    private final ArrayList<Person> mPeople = new ArrayList<>();



    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Spinner viewType = findViewById(R.id.viewTypeSpinner);
        Spinner adapterType = findViewById(R.id.adapterTypeSpinner);
        mListView = findViewById(R.id.mainActivity_ListView);
        mGridView = findViewById(R.id.mainActivity_GridLayout);

        viewType.setOnItemSelectedListener(viewTypeItemSelected);
        adapterType.setOnItemSelectedListener(adapterTypeItemSelected);
        mListView.setOnItemClickListener(listViewItemSelected);
        mGridView.setOnItemClickListener(gridViewItemSelected);
        populateDataCollection();
    }

    //Item Click Listener for ListView
    //Shows the AlertDialog for the selected object
    private final ListView.OnItemClickListener listViewItemSelected = new ListView.OnItemClickListener() {

        @Override
        public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
            showSelection(position);
        }
    };

    //Item Click listener for GridView
    //Shows the AlertDialog for the selected object
    private final GridView.OnItemClickListener gridViewItemSelected = new GridView.OnItemClickListener() {

        @Override
        public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
            showSelection(position);
        }
    };

    //Item selected listener for AdapterView
    //Swaps between GridView and ListView
    private final AdapterView.OnItemSelectedListener viewTypeItemSelected = new AdapterView.OnItemSelectedListener() {
        @Override
        public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
            Log.i(TAG, "onItemSelected: View Type Item selected in position: " + position);
            if (position == 1) {
                mGridView.setVisibility(View.VISIBLE);
                mListView.setVisibility(View.GONE);
            } else {
                mGridView.setVisibility(View.GONE);
                mListView.setVisibility(View.VISIBLE);
            }
        }

        @Override
        public void onNothingSelected(AdapterView<?> parent) {

        }
    };

    //When an adapter type is selected, setup that type of adapter for the ListView and GridView
    private final AdapterView.OnItemSelectedListener adapterTypeItemSelected = new AdapterView.OnItemSelectedListener() {
        @Override
        public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
            Log.i(TAG, "onItemSelected: Adapter Item selected in position: " + position);
            switch (position) {
                case 0:
                    setupArrayAdapter();
                    break;
                case 1:
                    setupSimpleAdapter();
                    break;
                case 2:
                    setupBaseAdapter();
                    break;
            }
        }

        @Override
        public void onNothingSelected(AdapterView<?> parent) {
        }
    };

    //This method populates the data Collection
    private void populateDataCollection() {
        mPeople.add(new Person("Bob", "Marley", "04/14/1983", R.drawable.image_1));
        mPeople.add(new Person("Suit", "Aleo", "12/14/1793", R.drawable.image_2));
        mPeople.add(new Person("Onet", "Ime", "05/14/1893", R.drawable.image_3));
        mPeople.add(new Person("Inb", "Andca", "11/24/1994", R.drawable.image_4));
        mPeople.add(new Person("Mpi", "Wen", "02/13/1944", R.drawable.image_5));
        mPeople.add(new Person("To", "Schoo", "07/20/1920", R.drawable.image_6));
        mPeople.add(new Person("Lbut", "Ididnt", "10/13/1953", R.drawable.image_7));
        mPeople.add(new Person("Makei", "Tback", "06/03/1997", R.drawable.image_8));
        mPeople.add(new Person("Hom", "Eont", "09/06/1973", R.drawable.image_9));
        mPeople.add(new Person("Imes", "Oiwa", "10/13/2000", R.drawable.image_10));
    }

    //Method for setting up the Base Adapter
    private void setupBaseAdapter() {

        AdapterWithPhotos listViewAdapter = new AdapterWithPhotos(MainActivity.this, mPeople, R.layout.listview_layout_withphotos);

        mListView.setAdapter(listViewAdapter);
        mGridView.setAdapter(listViewAdapter);
    }

    //Method for setting up the simple adapter
    private void setupSimpleAdapter() {
        final String keyName = "name";
        final String keyBirthday = "birthday";


        ArrayList<HashMap<String, String>> dataCollection = new ArrayList<>();

        for(Person p: mPeople) {
            HashMap<String, String> map = new HashMap<>();

            map.put(keyName, p.toString());
            map.put(keyBirthday, p.getmBirthday());

            dataCollection.add(map);
        }

        String[] keys = new String[] {
                keyName,
                keyBirthday
        };

        int[] viewIDs = new int[] {
                R.id.name,
                R.id.birthday
        };

        SimpleAdapter listViewAdapter = new SimpleAdapter(this, dataCollection, R.layout.listview_layout_simple,keys, viewIDs);
        mListView.setAdapter(listViewAdapter);
        mGridView.setAdapter(listViewAdapter);
    }

    //Method for setting up the array adapter
    private void setupArrayAdapter() {

        ArrayAdapter<Person> listViewAdapter = new ArrayAdapter<>(
                this,
                android.R.layout.simple_list_item_1,
                mPeople
        );


        mListView.setAdapter(listViewAdapter);
        mGridView.setAdapter(listViewAdapter);
    }

    //Method for displaying the alert dialog with the data of the selected person.
    private void showSelection(int position) {
        final Person selectedPerson = mPeople.get(position);

        TextView myMsg = new TextView(this);
        myMsg.setText(selectedPerson.getmBirthday());
        myMsg.setGravity(Gravity.CENTER_HORIZONTAL);
        AlertDialog.Builder alert = new AlertDialog.Builder(this);
        alert.setTitle(selectedPerson.toString());
        alert.setView(myMsg);
        alert.setIcon(selectedPerson.getmProfileImage());
        alert.setPositiveButton("CLOSE", null);
        alert.show();
    }
}
