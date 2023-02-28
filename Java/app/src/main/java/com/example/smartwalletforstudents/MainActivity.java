package com.example.smartwalletforstudents;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.FragmentTransaction;

import android.os.Bundle;
import android.view.MenuItem;
import android.widget.FrameLayout;


import com.example.smartwalletforstudents.Fragments.HomeFragment;
import com.example.smartwalletforstudents.Fragments.MarketFragment;
import com.example.smartwalletforstudents.Fragments.UserLoginedFragment;
import com.google.android.material.bottomnavigation.BottomNavigationView;
import com.google.android.material.navigation.NavigationBarView;

public class MainActivity extends AppCompatActivity {

    BottomNavigationView navigationView;
    FrameLayout container;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        FragmentTransaction fragmentTransaction = getSupportFragmentManager().beginTransaction();
        fragmentTransaction.replace(R.id.fl_container,new HomeFragment());
        fragmentTransaction.commit();

        navigationView = findViewById(R.id.bottom_nav);
        container = findViewById(R.id.fl_container);

        navigationView.setOnItemSelectedListener(new NavigationBarView.OnItemSelectedListener() {
            @Override
            public boolean onNavigationItemSelected(@NonNull MenuItem item) {
                FragmentTransaction fragmentTransaction = getSupportFragmentManager().beginTransaction();
                switch (item.getItemId()){
                    case R.id.nav_menu_home:
                        fragmentTransaction.replace(R.id.fl_container,new HomeFragment());
                        fragmentTransaction.commit();
                        break;
                    case R.id.nav_menu_market:
                        fragmentTransaction.replace(R.id.fl_container,new MarketFragment());
                        fragmentTransaction.commit();
                        break;
                    case R.id.nav_menu_user:
                        fragmentTransaction.replace(R.id.fl_container,new UserLoginedFragment());
                        fragmentTransaction.commit();
                        break;
                }
                return true;
            }
        });
    }
}