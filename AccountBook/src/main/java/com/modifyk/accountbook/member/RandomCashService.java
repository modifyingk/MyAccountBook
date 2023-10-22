package com.modifyk.accountbook.member;

import java.util.Random;

import org.springframework.stereotype.Service;

@Service
public class RandomCashService {

	public int makeCash() {
		Random rand = new Random();
		double prob = rand.nextDouble();
		int cash = 0;
		
		if(prob <= 0.8) { // 80%
			cash = 500;
		} else if(prob <= 0.9) { // 10%
			cash = 1000;
		} else if(prob <= 0.95) { // 5%
			cash = 1500;
		} else if(prob <= 0.999) {
			cash = 2000;
		} else if(prob <= 0.99999) {
			cash = 2500;
		} else if(prob <= 0.9999999) {
			cash = 3000;
		} else if(prob <= 0.999999999) {
			cash = 3500;
		} else if(prob <= 0.99999999999) {
			cash = 4000;
		} else if(prob <= 0.9999999999999) {
			cash = 4500;
		} else {
			cash = 5000;
		}
		return cash;
	}
}
