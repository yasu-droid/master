package model;

import java.util.ArrayList;
import java.util.List;

public class TimeOptions {
	public static List<Integer> getMinuteOptions(){
		List<Integer> options = new ArrayList<>();
		for(int i = 0;i <= 60; i ++) {
			options.add(i);
		}
		return options;
	}
}
