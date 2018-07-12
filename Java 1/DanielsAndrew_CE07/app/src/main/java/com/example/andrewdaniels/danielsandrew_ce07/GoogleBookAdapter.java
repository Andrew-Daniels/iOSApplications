package com.example.andrewdaniels.danielsandrew_ce07;

// Andrew Daniels
// JAV1 - C201805
// GoogleBookAdapter.java

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import com.squareup.picasso.Picasso;

import java.util.ArrayList;

class GoogleBookAdapter extends BaseAdapter {

    private final ArrayList<GoogleBooks> favoriteGoogleBooks;
    private final LayoutInflater mInflator;
    private final int mChildLayoutID;

    //Constructor for GoogleBookAdapter class
    public GoogleBookAdapter(Context _context, ArrayList<GoogleBooks> favoriteGoogleBooks, int mChildLayoutID) {
        this.favoriteGoogleBooks = favoriteGoogleBooks;
        this.mChildLayoutID = mChildLayoutID;

        mInflator = (LayoutInflater) _context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
    }

    //Create ViewHolderItem to easily get access to the UI Elements for the view.
    static class ViewHolderItem {
        final TextView titleTextView;
        final ImageView coverImage;

        ViewHolderItem(View _convertView) {
            this.titleTextView = _convertView.findViewById(R.id.bookTitle);
            this.coverImage = _convertView.findViewById(R.id.bookCoverImage);
        }
    }

    //Returns the number of books inside the favorites list.
    @Override
    public int getCount() {
        if (favoriteGoogleBooks.size() > 0) {
            return favoriteGoogleBooks.size();
        }
        return 0;
    }

    //Returns the GoogleBook at the selected position
    @Override
    public GoogleBooks getItem(int position) {
        if (favoriteGoogleBooks != null && position >= 0 && position < favoriteGoogleBooks.size()) {
            return favoriteGoogleBooks.get(position);
        }
        return null;
    }

    //Returns the ID for GoogleBook at the position
    @Override
    public long getItemId(int position) {
        long ID_CONSTANT = 0x0010000;
        return ID_CONSTANT + position;
    }

    //Creates the view for each Google Book in the array list.
    @Override
    public View getView(int position, View _convertView, ViewGroup parent) {
        ViewHolderItem viewHolderItem;
        if (_convertView == null) {
            _convertView = mInflator.inflate(mChildLayoutID, parent, false);
            viewHolderItem = new ViewHolderItem(_convertView);

            _convertView.setTag(viewHolderItem);
        } else {
            viewHolderItem = (ViewHolderItem) _convertView.getTag();
        }
        final GoogleBooks book = favoriteGoogleBooks.get(position);

        Picasso.get().load(book.getImageURL()).into(viewHolderItem.coverImage);
        viewHolderItem.titleTextView.setText(book.getTitle());


        return _convertView;
    }
}
