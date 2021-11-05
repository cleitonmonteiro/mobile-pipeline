import React, { useEffect, useState } from "react";
import { StyleSheet, Text, View, FlatList, Button } from "react-native";

const serverUrl = "http://192.168.0.7:3000/orders";

export default function App() {
  const [orders, setOrders] = useState([]);
  const [loading, setLoading] = useState(false);

  const fetchOrders = () => {
    setLoading(true);
    fetch(serverUrl)
      .then((res) => res.json())
      .then((data) => {
        setOrders(data);
        setLoading(false);
      })
      .catch((err) => {
        console.log(err);
        setLoading(false);
      });
  };

  useEffect(() => {
    fetchOrders();
  }, []);

  const handleDelivery = (id) => async () => {
    fetch(`${serverUrl}/${id}`, {
      method: "PUT",
      headers: {
        Accept: "application/json",
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        delivered: true,
      }),
    });
  };

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Orders</Text>
      <FlatList
        data={orders}
        onRefresh={fetchOrders}
        refreshing={loading}
        keyExtractor={(item) => item._id}
        renderItem={({ item }) => {
          return (
            <View style={styles.card}>
              <Text>{item.description}</Text>
              <Text>{`Delivered: ${item.delivered}`}</Text>
              <Text>{`Received: ${item.received}`}</Text>
              <View style={styles.deliveryBtn}>
                <Button title="Delivery" onPress={handleDelivery(item._id)} />
              </View>
            </View>
          );
        }}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  title: {
    fontSize: 24,
    fontWeight: "bold",
    paddingVertical: 10,
  },
  container: {
    flex: 1,
    padding: 30,
    marginTop: 30,
    backgroundColor: "#fff",
    alignItems: "stretch",
    justifyContent: "center",
  },
  card: {
    flex: 1,
    minHeight: 40,
    borderColor: "gray",
    borderRadius: 4,
    borderWidth: 1,
    marginTop: 10,
    padding: 10,
  },
  deliveryBtn: {
    paddingVertical: 10,
  },
});
