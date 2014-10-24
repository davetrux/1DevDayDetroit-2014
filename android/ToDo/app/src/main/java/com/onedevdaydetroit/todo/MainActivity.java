package com.onedevdaydetroit.todo;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.*;
import com.onedevdaydetroit.todo.data.SqlLiteProvider;
import com.onedevdaydetroit.todo.data.ToDo;

import java.util.List;


public class MainActivity extends Activity {

    private TextView mNewTaskText;
    private List<ToDo> mData;
    private ListView mTaskView;
    private SqlLiteProvider mProvider;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        mTaskView = (ListView) findViewById(R.id.taskList);

        mNewTaskText = (TextView) findViewById(R.id.taskText);

        Button action = (Button) findViewById(R.id.newTask);
        action.setOnClickListener(this.handleNewTaskEvent);

        mProvider = new SqlLiteProvider(this);

        mData = findPersistedRecords();

        if(!mData.isEmpty()) {
            BindToDoList();
        }
    }

    private final View.OnClickListener handleNewTaskEvent = new View.OnClickListener() {
        @Override
        public void onClick(final View view) {

            ToDo newItem = new ToDo();
            newItem.setTitle(mNewTaskText.getText().toString());
            newItem.setId(mProvider.getNextId());
            mProvider.addTask(newItem);

            mData.add(newItem);

            BindToDoList();

            mNewTaskText.setText("");
        }
    };

    /**
     * Helper method to put the list of items into the ListView
     */
    private void BindToDoList() {
        final ToDoAdapter adapter = new ToDoAdapter(this, mData);
        mTaskView.setAdapter(adapter);

        mTaskView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(final AdapterView<?> parent, final View view, final int position, final long id) {

                final TextView v = (TextView) view;

                final long todoId = (Long) v.getTag();

                //Remove from the local database
                final SqlLiteProvider provider = new SqlLiteProvider(parent.getContext());
                provider.deleteTask(todoId);

                mData.remove(position);

                BindToDoList();
            }
        });
    }

    /**
     * Find any objects in the database
     * @return An ArrayList of To-Do objects
     */
    protected List<ToDo> findPersistedRecords() {

        List<ToDo> result = mProvider.findAll();

        return result;
    }
}
