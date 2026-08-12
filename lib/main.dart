import 'package:flutter/material.dart';

/// NOEMA — premium dark AI-analytics. Flutter mirror of the web concept.
/// Direction: near-black ink slab, ONE acid-green scarce accent, Fraunces/
/// Space-Grotesk feel, live readout, no purple, no generic Material-blue.
void main() => runApp(const NoemaApp());

class NoemaApp extends StatelessWidget {
  const NoemaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NOEMA',
      debugShowCheckedModeBanner: false,
      theme: _noemaTheme(),
      home: const NoemaHome(),
    );
  }

  ThemeData _noemaTheme() {
    const accent = Color(0xFFD8F90A);
    const bg = Color(0xFF050505);
    const fg = Color(0xFFF2F2F2);
    const muted = Color(0xFF83837D);
    final base = ThemeData.dark(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: bg,
      colorScheme: const ColorScheme.dark(
        primary: accent,
        onPrimary: Color(0xFF0A0A0A),
        surface: Color(0xFF0A0A0A),
        onSurface: fg,
        secondary: Color(0xFF101010),
        onSecondary: fg,
      ),
      textTheme: base.textTheme.apply(
        bodyColor: fg,
        displayColor: fg,
        fontFamily: 'monospace', // system-serif fallback keeps it non-generic
      ),
    );
  }
}

class NoemaHome extends StatefulWidget {
  const NoemaHome({super.key});
  @override
  State<NoemaHome> createState() => _NoemaHomeState();
}

class _NoemaHomeState extends State<NoemaHome> {
  final List<String> _readouts = [
    '11:04 UTC — checkout conversion dipped 12%. Cause: a pricing experiment went live at 10:58.',
    '11:11 UTC — signup funnel held steady for the 40th day. Only variance: a shared link on a partner blog.',
    '11:19 UTC — latency P99 rose 210ms. Cause: a dependency deploy at 11:02. Rollback is safe.',
  ];
  int _i = 0;

  @override
  Widget build(BuildContext context) {
    final accent = const Color(0xFFD8F90A);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.circle, size: 22, color: accent),
                  const SizedBox(width: 10),
                  const Text('NOEMA', style: TextStyle(fontWeight: FontWeight.w700, letterSpacing: 3)),
                ],
              ),
              const SizedBox(height: 48),
              Text('The numbers moved.', style: _title(accent)),
              RichText(
                text: TextSpan(children: [
                  TextSpan(text: 'Why', style: _accent(accent)),
                  TextSpan(text: ' is the product.', style: _title(accent)),
                ]),
              ),
              const SizedBox(height: 16),
              Text(
                'NOEMA ingests raw events, isolates the cause inside every metric, '
                'and writes the verdict in plain language. No SQL. No waiting. The machine explains.',
                style: const TextStyle(color: Color(0xFFC9C9C3), height: 1.6),
              ),
              const SizedBox(height: 28),
              Wrap(spacing: 12, runSpacing: 12, children: [
                _pill('Start free', accent: true),
                _pill('Watch it think'),
              ]),
              const SizedBox(height: 56),
              _panel('LIVE EVIDENCE', text: _readouts[_i], accent: accent),
              const SizedBox(height: 18),
              _metric('anomalies this week', '214', accent),
              const SizedBox(height: 10),
              _metric('median time to verdict', '3.1s', accent),
              const SizedBox(height: 10),
              _metric('causes auto-attributed', '98%', accent),
              const SizedBox(height: 40),
              const Text(
                '© NOEMA analytics · autonomous causal analytics',
                style: TextStyle(color: Color(0xFF5c5c57), fontSize: 12),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: accent,
        foregroundColor: const Color(0xFF0A0A0A),
        onPressed: () => setState(() => _i = (_i + 1) % _readouts.length),
        child: const Icon(Icons.refresh),
      ),
    );
  }

  TextStyle _title(Color accent) =>
      const TextStyle(fontFamily: 'serif', fontSize: 40, height: 1.05, fontWeight: FontWeight.w500, color: Color(0xFFF2F2F2));
  TextStyle _accent(Color accent) => const TextStyle(fontFamily: 'serif', fontStyle: FontStyle.italic, fontWeight: FontWeight.w300, color: Color(0xFFD8F90A), fontSize: 40, height: 1.05);

  Widget _pill(String label, {bool accent = false}) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
        decoration: BoxDecoration(
          color: accent ? const Color(0xFFD8F90A) : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: accent ? const Color(0xFFD8F90A) : const Color(0xFF26262a)),
        ),
        child: Text(label, style: TextStyle(color: accent ? const Color(0xFF0A0A0A) : const Color(0xFFF2F2F2), fontWeight: FontWeight.w500)),
      );

  Widget _panel(String eyebrow, {required String text, required Color accent}) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF202022)),
          borderRadius: BorderRadius.circular(16),
          color: const Color(0xFF0A0A0A),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(eyebrow, style: TextStyle(color: accent, fontSize: 11, letterSpacing: 2)),
          const SizedBox(height: 12),
          Text(text, style: const TextStyle(fontFamily: 'serif', fontSize: 19, height: 1.4, color: Color(0xFFF2F2F2))),
        ]),
      );

  Widget _metric(String label, String value, Color accent) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(border: Border.all(color: const Color(0xFF1c1c1f)), borderRadius: BorderRadius.circular(12)),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(label, style: const TextStyle(color: Color(0xFF8A8A84))),
          Text(value, style: TextStyle(color: accent, fontFamily: 'monospace', fontSize: 18, fontFeatures: const [FontFeature.tabularFigures()])),
        ]),
      );
}