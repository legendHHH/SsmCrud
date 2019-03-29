package com.legend.utils;

/**
 * @author Create By legend
 * @date 2019/3/27 20:03
 */
public class U {

    //输入一个正数n，输出所有和为n的连续正数序列
    public static void find(int n){
        int min = 1;
        int max = 1;
        int sum = 1;

        while (max<=n/2+1){
            if (sum == n){
                for (int i = min; i <= max; i++) {
                    System.out.print(i+" ");
                }
                System.out.println("");
                sum-=min;
                min++;
                max++;
                sum+=max;
            }

            if (sum>n){
                sum-=min;
                min++;
            }else {
                max++;
                sum+=max;
            }
        }
    }


    //字符串反转
    public static String converString(String str){
        if (str.length()==1){
            return str;
        }
        return converString(str.substring(1))+str.charAt(0);

    }

    //二分查找第一次出现重复数字的位置
    public static int BinarySearch(int[] arr,int n,int val){
        int low = 0;
        int high = n-1;
        int mid;
        while (low<=high){
            mid = (low+high)/2;

            if (arr[mid] == val){
                for (int i = mid; i >=0 ; i--) {
                    if (arr[i] ==arr[mid]){
                        mid = i;
                        continue;
                    }else {
                        break;
                    }
                }
                return mid;
            }

            if (arr[mid] >val){
                high = mid-1;
            }else {
                low = mid+1;
            }
        }
        return -1;
    }


    //二分查找是已经排好序的数组
    public static void sort(int[] arr){
        for (int i = 0; i < arr.length; i++) {
            for (int j = 0; j < i; j++) {
                if (arr[i]<arr[j]){
                    int temp = arr[i];
                    arr[i] = arr[j];
                    arr[j] = temp;
                }
            }
        }
        for (int i = 0; i < arr.length; i++) {
            System.out.print(arr[i]+" ");
        }
    }

    public static void main(String[] args){
        int[] A = {4,2,1,5,9,2,4,5};
        //int val = 3;
        int val = 2;
        int n = A.length;
        sort(A);
        int i = BinarySearch(A, n, val);
        System.out.println("第一次出现的位置是"+i);

        //测试字符串反转
        String hello = converString("Hello");
        System.out.println("反转后的字符串"+hello);

        //求连续和
        find(15);
    }
}
