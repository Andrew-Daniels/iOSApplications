package com.example.andrewdaniels.danielsandrew_ce05;

// Andrew Daniels
// JAV1 - C201804
// PersonAdapter.java

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

import java.util.ArrayList;

class PersonAdapter extends BaseAdapter {

    private static final long ID_CONSTANT = 0x0200000;
    private final ArrayList<Person> mDataCollection;
    private final int mChildLayoutID;
    private final LayoutInflater mInflator;


    //Constructor for PersonAdapter
    public PersonAdapter(Context _context, ArrayList<Person> mDataCollection, int mChildLayoutID) {
        this.mDataCollection = mDataCollection;
        this.mChildLayoutID = mChildLayoutID;

        mInflator = (LayoutInflater) _context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
    }

    static class ViewHolderItem {
        TextView name;
        TextView birthDate;
    }

    //Set the amount of views to display based off the dataCollection
    @Override
    public int getCount() {
        if(mDataCollection != null) {
            return mDataCollection.size();
        }
        return 0;
    }

    //Get the item at the specified position
    @Override
    public Person getItem(int _position) {
        if(mDataCollection != null && _position < mDataCollection.size() && _position >= 0) {
            return mDataCollection.get(_position);
        }
        return null;
    }

    //Create a unique ID for the view
    @Override
    public long getItemId(int _position) {
        return ID_CONSTANT + _position;
    }

    //Create the view at the specified position
    @Override
    public View getView(int _position, View _convertView, ViewGroup _parent) {
        ViewHolderItem viewHolderItem;
        if (_convertView == null) {
            _convertView = mInflator.inflate(mChildLayoutID, _parent, false);

            viewHolderItem = new ViewHolderItem();

            viewHolderItem.name = _convertView.findViewById(R.id.listview_layout_name);
            viewHolderItem.birthDate = _convertView.findViewById(R.id.listview_layout_birth);

            _convertView.setTag(viewHolderItem);
        } else {
            viewHolderItem = (ViewHolderItem) _convertView.getTag();

        }

        Person person = mDataCollection.get(_position);

        viewHolderItem.name.setText(person.toString());
        viewHolderItem.birthDate.setText(person.getmBirthday());


        return _convertView;
    }
}
