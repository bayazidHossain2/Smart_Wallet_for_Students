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
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.example.smartwalletforstudents.R;

public class HomeFragment extends Fragment {

    TextView balance,spand,deposit,save,spandA,depositA,saveA,add,desc1,desc2,desc3,desc4;
    EditText inputMoney,inputDesc;
    LinearLayout linearLayoutMoney,linearLayoutDesc;
    ImageView reset,cancle;
    TextView oneTaka,twoTaka,fiveTaka,tenTaka,twentyTaka,fiftyTaka,hundTaka,halfTaka,thousandTaka;

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
        balance = view.findViewById(R.id.tv_btn_balance);
        spand = view.findViewById(R.id.tv_spand);
        deposit = view.findViewById(R.id.tv_deposit);
        save = view.findViewById(R.id.tv_save);
        spandA = view.findViewById(R.id.tv_spand_amount);
        depositA = view.findViewById(R.id.tv_deposit_amount);
        saveA = view.findViewById(R.id.tv_save_amount);
        add = view.findViewById(R.id.tv_btn_add);
        desc1 = view.findViewById(R.id.tv_desc_one);
        desc2 = view.findViewById(R.id.tv_desc_two);
        desc3 = view.findViewById(R.id.tv_desc_three);
        desc4 = view.findViewById(R.id.tv_desc_four);
        inputMoney = view.findViewById(R.id.et_money);
        inputDesc = view.findViewById(R.id.et_desc);
        oneTaka = view.findViewById(R.id.tv_btn_one_taka);
        tenTaka = view.findViewById(R.id.tv_btn_two_taka);
        fiveTaka = view.findViewById(R.id.tv_btn_five_taka);
        tenTaka = view.findViewById(R.id.tv_btn_ten_taka);
        twentyTaka = view.findViewById(R.id.tv_btn_twenty_taka);
        fiftyTaka = view.findViewById(R.id.tv_btn_fifty_taka);
        hundTaka = view.findViewById(R.id.tv_btn_hundred_taka);
        halfTaka = view.findViewById(R.id.tv_btn_half_thousand_taka);
        thousandTaka = view.findViewById(R.id.tv_btn_thousand_taka);

        spand.setBackground(null);
        linearLayoutMoney = view.findViewById(R.id.ll_money);
        linearLayoutDesc = view.findViewById(R.id.ll_desc);
        reset = view.findViewById(R.id.iv_reset);
        cancle = view.findViewById(R.id.iv_cancle);

        balance.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if(balance.getText().toString().equals("Balance")){
                    balance.setText("12547 /-");
                    spandA.setText("7548 /-");
                    depositA.setText("145 /-");
                    saveA.setText("3654781 /-");
                }else{
                    balance.setText("Balance");
                    spandA.setText("");
                    depositA.setText("");
                    saveA.setText("");
                }
            }
        });

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
                reset.setBackground(drawable);
                cancle.setBackground(drawable);
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
                reset.setBackground(drawable);
                cancle.setBackground(drawable);
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
                reset.setBackground(drawable);
                cancle.setBackground(drawable);
            }
        });
    }
}