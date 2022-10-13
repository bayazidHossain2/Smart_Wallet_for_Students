package com.example.smartwalletforstudents.Fragments;

import static com.example.smartwalletforstudents.R.drawable.text_background_deposit;
import static com.example.smartwalletforstudents.R.drawable.text_background_save;
import static com.example.smartwalletforstudents.R.drawable.text_background_spand;

import android.graphics.drawable.Drawable;
import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;

import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.example.smartwalletforstudents.R;

public class HomeFragment extends Fragment {

    TextView spand,deposit,save;
    LinearLayout linearLayoutMoney,linearLayoutDesc;

    public HomeFragment() {
        // Required empty public constructor
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {

        return inflater.inflate(R.layout.fragment_home, container, false);
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        spand = view.findViewById(R.id.tv_spand);
        deposit = view.findViewById(R.id.tv_deposit);
        save = view.findViewById(R.id.tv_save);
        spand.setBackground(null);
        linearLayoutMoney = view.findViewById(R.id.ll_money);
        linearLayoutDesc = view.findViewById(R.id.ll_desc);

        spand.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Toast.makeText(view.getContext(),"Spand clicked",Toast.LENGTH_SHORT).show();
                spand.setBackground(null);
                Drawable drawable = view.getResources().getDrawable(text_background_deposit);
                deposit.setBackground(drawable);
                drawable = view.getResources().getDrawable(text_background_save);
                save.setBackground(drawable);
                drawable = view.getResources().getDrawable(text_background_spand);
                linearLayoutMoney.setBackground(drawable);
                linearLayoutDesc.setBackground(drawable);
            }
        });

        deposit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Toast.makeText(view.getContext(),"deposit clicked",Toast.LENGTH_SHORT).show();
                deposit.setBackground(null);
                Drawable drawable = view.getResources().getDrawable(text_background_spand);
                spand.setBackground(drawable);
                drawable = view.getResources().getDrawable(text_background_save);
                save.setBackground(drawable);
                drawable = view.getResources().getDrawable(text_background_deposit);
                linearLayoutMoney.setBackground(drawable);
                linearLayoutDesc.setBackground(drawable);
            }
        });

        save.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Toast.makeText(view.getContext(),"save clicked",Toast.LENGTH_SHORT).show();
                save.setBackground(null);
                Drawable drawable = view.getResources().getDrawable(text_background_deposit);
                deposit.setBackground(drawable);
                drawable = view.getResources().getDrawable(text_background_spand);
                spand.setBackground(drawable);
                drawable = view.getResources().getDrawable(text_background_save);
                linearLayoutMoney.setBackground(drawable);
                linearLayoutDesc.setBackground(drawable);
            }
        });
    }
}