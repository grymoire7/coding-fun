package com.magicbydesign.codingfun;

import java.util.ArrayList;

// Sash = Simple hash
public class SashMap<K, V> {
    
    static final boolean DEBUG = false;
    private int size;

    private int numBuckets = 10;
    private ArrayList<ArrayList<Node>> bucketList = new ArrayList<>();
    
    private class Node {
        public K key;
        public V value;
        
        public Node(K key, V value) {
            this.key = key;
            this.value = value;
        }
    }
    
    public int size() { return size; }
    public boolean isEmpty() { return (size == 0); }
    public int getNumBuckets() { return numBuckets; }
    
    public SashMap() {
    	size = 0;
        // put lists of nodes in our buckets
        bucketList.ensureCapacity(numBuckets);
        for (int i=0; i < numBuckets; i++) {
            bucketList.add(new ArrayList<Node>());
        }
    }
    
    public void add(K key, V value) {
        int bucketNum = getBucketNum(key);
        ArrayList<Node> bucket = bucketList.get(bucketNum);

        if (DEBUG) {
            System.out.println("add: (k, v) = (" + key + ", " + value + "), key hashcode = " + key.hashCode() + ", bucket = " + bucketNum);
        }

        Node foundNode = null;
        for (Node testNode : bucket) {
            if (testNode.key.equals(key)) {
                foundNode = testNode;
                break;
            }
        }
        if (foundNode != null) {
            foundNode.value = value;
        }
        else {
            foundNode = new Node(key, value);
            bucket.add(foundNode);
            size++;
        }
        
        // rehash if load is high (>= 0.7)
        if ( 1.0*size/numBuckets >= 0.7 ) {
			if (DEBUG) {
				System.out.println("rehash (size=" + size + ", buckets=" + numBuckets + ") ...");
			}

			ArrayList<ArrayList<Node>> tempBucketList = bucketList;
			bucketList = new ArrayList<>();
        	numBuckets = 2 * numBuckets;
        	bucketList.ensureCapacity( numBuckets );

			for (int i=0; i < numBuckets; i++) {
				bucketList.add(new ArrayList<Node>());
			}

        	for (ArrayList<Node> b : tempBucketList) {
        		for (Node node : b) {
					int bNum = getBucketNum(node.key);
					bucketList.get(bNum).add(node);
        		}
        	}
        }
    }
    
    public V remove(K key) {
        int bucketNum = getBucketNum(key);
        ArrayList<Node> bucket = bucketList.get(bucketNum);
        Node node = getNode(key);
        if (node != null) {
			bucket.removeIf(n -> { return n.key.equals(key); });
			size--;
			return node.value;
        }
    	return null;
    }
    
    private int getBucketNum(K key) {
        return key.hashCode() % (numBuckets - 1);
    }
    
    private Node getNode(K key) {
        Node foundNode = null;
        int bucketNum = getBucketNum(key);
        ArrayList<Node> bucket = bucketList.get(bucketNum);

        for (Node testNode : bucket) {
			if (testNode.key.equals(key)) {
				foundNode = testNode;
				break;
			}
        }

        if (DEBUG && (foundNode != null)) {
			System.out.println("get: (k, v) = (" + key + ", " + foundNode.value + "), key hashcode = " + key.hashCode());
        }

        return foundNode;
    }
    
    public V get(K key) {
    	Node node = getNode(key);
        V ret = null;
        if (node != null) {
        	ret = node.value;
        }

        return ret;
    }
    
    public static void test(boolean cond, String testName) {
		System.out.println(testName + (cond ? ": pass" : ": fail"));
    }

    public static void main(String[] args) {
        SashMap<Integer, Integer> sm = new SashMap<>();
        
        SashMap.test(sm.getNumBuckets() == 10, "initial buckets");
        sm.add(1, 11);
        sm.add(2, 22);
        sm.add(3, 33);
        sm.add(4, 44);
        sm.add(5, 55);
        sm.add(6, 66);
        SashMap.test(sm.getNumBuckets() == 10, "buckets before rehash");
        sm.add(7, 77);
        SashMap.test(sm.getNumBuckets() == 20, "buckets after rehash");
        sm.add(8, 88);
        sm.add(9, 99);
        sm.add(10, 1010);
        sm.add(11, 1111);
        sm.add(12, 1212);
        sm.add(13, 1313);
        sm.add(88888, 99999);
        test(sm.get(0) == null, "no item get");
        test(sm.get(1) == 11, "(1, 11) get");
        test(sm.get(2) == 22, "(2, 22) get");
        test(sm.get(12) == 1212, "(12, 1212) get");
        test(sm.get(88888) == 99999, "(88888, 99999) get");
        test(sm.size() == 14, "size");
        
        SashMap<String, Integer> si = new SashMap<>();
        si.add("one", 1);
        si.add("two", 2);
        si.add("three", 3);
        test(si.get("") == null, "('', null) get");
        test(si.get("one") == 1, "('one', 1) get");
        test(si.get("two") == 2, "('two', 2) get");
    }

}
