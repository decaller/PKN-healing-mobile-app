import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../../../../core/theme/theme_extensions.dart';

class KemitraanFormSheet extends StatefulWidget {
  final String? preselectedService;

  const KemitraanFormSheet({super.key, this.preselectedService});

  static Future<void> show(BuildContext context, {String? preselectedService}) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => KemitraanFormSheet(preselectedService: preselectedService),
    );
  }

  @override
  State<KemitraanFormSheet> createState() => _KemitraanFormSheetState();
}

class _KemitraanFormSheetState extends State<KemitraanFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late String _service;
  final TextEditingController _lembagaCtrl = TextEditingController();
  final TextEditingController _picCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _notesCtrl = TextEditingController();

  final List<String> _services = [
    'Konsultasi Kurikulum & SOP Karakter',
    'Visitasi & Audit Ekosistem Adab',
    'In-House Coaching Guru & Fasilitator',
    'Daurah Tematik Wali Santri / Parenting Day',
    'Studi Banding & Observasi Sekolah Mitra',
  ];

  @override
  void initState() {
    super.initState();
    _service = widget.preselectedService ?? _services.first;
    if (!_services.contains(_service)) {
      _services.insert(0, _service);
    }
  }

  @override
  void dispose() {
    _lembagaCtrl.dispose();
    _picCtrl.dispose();
    _phoneCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Jazakumullahu khairan! Pengajuan kemitraan dari ${_lembagaCtrl.text} telah diterima oleh Tim Pusat PKN.",
          ),
          backgroundColor: const Color(0xFF235347),
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.earthTree;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      padding: EdgeInsets.fromLTRB(20, 16, 20, 20 + bottomInset),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colors.textMuted.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 14),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF235347).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const iconoir.SendDiagonal(
                          width: 20,
                          height: 20,
                          color: Color(0xFF235347),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Formulir Kemitraan",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: colors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: iconoir.Xmark(
                      width: 20,
                      height: 20,
                      color: colors.textPrimary,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Dropdown Layanan
              Text(
                "Pilihan Program / Layanan",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: colors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: colors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: colors.tactileBorder),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _service,
                    isExpanded: true,
                    dropdownColor: colors.surfaceContainerLow,
                    items: _services.map((s) {
                      return DropdownMenuItem(
                        value: s,
                        child: Text(
                          s,
                          style: TextStyle(
                            fontSize: 13,
                            color: colors.textPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _service = val);
                    },
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // Nama Lembaga
              _buildTextField(
                label: "Nama Yayasan / Sekolah / Lembaga",
                hint: "Contoh: Kuttab Al-Fatih Balikpapan",
                controller: _lembagaCtrl,
                colors: colors,
                validator: (val) => val == null || val.isEmpty ? "Wajib diisi" : null,
              ),

              const SizedBox(height: 12),

              // Nama PIC & WhatsApp
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      label: "Nama Penanggung Jawab",
                      hint: "Nama Anda",
                      controller: _picCtrl,
                      colors: colors,
                      validator: (val) => val == null || val.isEmpty ? "Wajib diisi" : null,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildTextField(
                      label: "Nomor WhatsApp",
                      hint: "0812xxxx",
                      controller: _phoneCtrl,
                      colors: colors,
                      keyboardType: TextInputType.phone,
                      validator: (val) => val == null || val.isEmpty ? "Wajib diisi" : null,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Catatan Kebutuhan
              _buildTextField(
                label: "Uraian Singkat Kebutuhan / Masalah Adab",
                hint: "Tuliskan tantangan utama ekosistem adab di lembaga Anda...",
                controller: _notesCtrl,
                colors: colors,
                maxLines: 3,
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _submit,
                  icon: const iconoir.Check(width: 18, height: 18, color: Colors.white),
                  label: const Text(
                    "Kirim Pengajuan Kerjasama",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF235347),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required EarthTreeColors colors,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: colors.textPrimary,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: validator,
          style: TextStyle(fontSize: 13, color: colors.textPrimary),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(fontSize: 12, color: colors.textMuted),
            filled: true,
            fillColor: colors.surfaceContainerLow,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: colors.tactileBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: colors.tactileBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Color(0xFF235347), width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
