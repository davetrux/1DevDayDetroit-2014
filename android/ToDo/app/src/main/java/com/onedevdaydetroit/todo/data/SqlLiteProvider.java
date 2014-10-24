package com.onedevdaydetroit.todo.data;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by truxall on 4/18/2014.
 * Concrete implementation of DataProvider
 */
public class SqlLiteProvider implements DataProvider {

    private static final String DB_NAME = "tasks";
    private static final String TABLE_NAME = "tasks";
    private static final int DB_VERSION = 1;
    private static final String DB_CREATE_QUERY = "CREATE TABLE " + SqlLiteProvider.TABLE_NAME + " (id integer primary key, title text not null);";

    private final SQLiteDatabase storage;
    private final SQLiteOpenHelper helper;

    public SqlLiteProvider(final Context ctx)
    {
        this.helper = new SQLiteOpenHelper(ctx, SqlLiteProvider.DB_NAME, null, SqlLiteProvider.DB_VERSION)
        {
            @Override
            public void onCreate(final SQLiteDatabase db)
            {
                db.execSQL(SqlLiteProvider.DB_CREATE_QUERY);
            }

            @Override
            public void onUpgrade(final SQLiteDatabase db, final int oldVersion,
                                  final int newVersion)
            {
                db.execSQL("DROP TABLE IF EXISTS " + SqlLiteProvider.TABLE_NAME);
                this.onCreate(db);
            }
        };

        this.storage = this.helper.getWritableDatabase();
    }


    @Override
    public void addTask(final ToDo item) {
        final ContentValues data = new ContentValues();
        data.put("title", item.getTitle());
        data.put("id", item.getId());

        this.storage.insert(SqlLiteProvider.TABLE_NAME, null, data);
    }

    @Override
    public long getNextId() {
        String query = "SELECT MAX(id) AS max_id FROM " + SqlLiteProvider.TABLE_NAME;
        Cursor cursor = this.storage.rawQuery(query, null);

        int id = 0;
        if (cursor.moveToFirst())
        {
            do
            {
                id = cursor.getInt(0);
            } while(cursor.moveToNext());
        }
        return id + 1;
    }

    @Override
    public void deleteAll() {
        this.storage.delete(SqlLiteProvider.TABLE_NAME, null, null);
    }

    @Override
    public void deleteTask(final long id) {
        this.storage.delete(SqlLiteProvider.TABLE_NAME, "id=" + id, null);
    }

    @Override
    public List<ToDo> findAll() {
        final ArrayList<ToDo> tasks = new ArrayList<ToDo>();

        final Cursor c = this.storage.query(SqlLiteProvider.TABLE_NAME, new String[]
                { "id", "title" }, null, null, null, null, null);

        if (c != null)
        {
            c.moveToFirst();

            while (c.isAfterLast() == false)
            {
                ToDo item = new ToDo();
                item.setId(c.getLong(0));
                item.setTitle(c.getString(1));
                tasks.add(item);
                c.moveToNext();
            }

            c.close();
        }

        return tasks;
    }
}
