import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart'; // Import logger

class OrderMenuView extends GetView {
  final Logger logger = Logger(); // Initialize logger

  // Hapus kata kunci 'const' dari konstruktor
  OrderMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    String selectedLaundryType = '';
    String selectedServicePackage = 'Regular'; // Default to Regular
    String selectedPickupOption = 'Antar Jemput'; // Default to Antar Jemput

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Tipe',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown for Laundry Type
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Tipe Laundry'),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Cuci Aja',
                      child: Text('Cuci Aja'),
                    ),
                    DropdownMenuItem(
                      value: 'Cuci Setrika',
                      child: Text('Cuci Setrika'),
                    ),
                    DropdownMenuItem(
                      value: 'Dry Cleaning',
                      child: Text('Dry Cleaning'),
                    ),
                    DropdownMenuItem(
                      value: 'Karpet',
                      child: Text('Karpet'),
                    ),
                    DropdownMenuItem(
                      value: 'Custom',
                      child: Text('Custom'),
                    ),
                    DropdownMenuItem(
                      value: 'Sepatu & Tas',
                      child: Text('Sepatu & Tas'),
                    ),
                  ],
                  onChanged: (value) {
                    selectedLaundryType = value ?? '';
                  },
                  icon: const Icon(Icons.keyboard_arrow_down),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Keterangan Input
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Masukkan keterangan',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Package Selection
            const Text(
              'Pilih jenis paket',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedServicePackage = 'Regular';
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: selectedServicePackage == 'Regular'
                            ? Colors.grey[800]
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: const [
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.white),
                              SizedBox(width: 8),
                              Text(
                                'Regular',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          Text(
                            'Estimasi 2 Hari',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedServicePackage = 'Express';
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: selectedServicePackage == 'Express'
                            ? Colors.grey[800]
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: const [
                          Row(
                            children: [
                              Icon(Icons.bolt),
                              SizedBox(width: 8),
                              Text('Express'),
                            ],
                          ),
                          Text(
                            'Estimasi 1 Hari',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Delivery Type Selection
            const Text(
              'Pilih jenis pengantar',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedPickupOption = 'Antar Jemput';
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: selectedPickupOption == 'Antar Jemput'
                            ? Colors.grey[800]
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.local_shipping, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            'Antar Jemput',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedPickupOption = 'Jemput Aja';
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: selectedPickupOption == 'Jemput Aja'
                            ? Colors.grey[800]
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.directions_car),
                          SizedBox(width: 8),
                          Text('Jemput Aja'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),

            // Payment Options
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Logic for immediate payment
                      logger.i('Selected Laundry Type: $selectedLaundryType');
                      logger.i(
                          'Selected Service Package: $selectedServicePackage');
                      logger.i('Selected Pickup Option: $selectedPickupOption');
                      // Simpan data ke Firebase atau lakukan tindakan lain
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Bayar Sekarang',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Logic for deferred payment
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Bayar Nanti',
                      style: TextStyle(color: Colors.grey[800]),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
