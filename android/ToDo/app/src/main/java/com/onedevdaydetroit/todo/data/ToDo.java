package com.onedevdaydetroit.todo.data;

import android.os.Parcel;
import android.os.Parcelable;

public class ToDo implements Parcelable {

    private Long mId;

    private String mTitle;

    /*
     * Default constructor for general object creation
     */
    public ToDo() {

    }

    /*
     * Constructor needed for parcelable object creation
     */
    public ToDo(Parcel item) {
        mId = item.readLong();
        mTitle = item.readString();
    }

    public Long getId() {
        return mId;
    }

    public void setId(Long id) {
        this.mId = id;
    }

    public String getTitle() {
        return mTitle;
    }

    public void setTitle(String title) {
        this.mTitle = title;
    }

    /*
     * Used to generate parcelable classes from a parcel
     */
    public static final Parcelable.Creator<ToDo> CREATOR
            = new Parcelable.Creator<ToDo>() {
        public ToDo createFromParcel(Parcel in) {
            return new ToDo(in);
        }

        public ToDo[] newArray(int size) {
            return new ToDo[size];
        }
    };

    @Override
    public int describeContents() {
        return 0;
    }

    @Override
    public void writeToParcel(Parcel parcel, int i) {
        if(mId != null) {
            parcel.writeLong(mId);
        }
        else {
            parcel.writeLong(-1);
        }
        parcel.writeString(mTitle);
    }
}
