import 'package:flutter/material.dart';
import '../models/song.dart';

class SongRankingList extends StatefulWidget {
  const SongRankingList({super.key});

  @override
  State<SongRankingList> createState() => _SongRankingListState();
}

class _SongRankingListState extends State<SongRankingList> {
  final List<Song> _songs = [
    Song(id: '1', title: 'Blinding Lights', artist: 'The Weeknd'),
    Song(id: '2', title: 'Shape of You', artist: 'Ed Sheeran'),
    Song(id: '3', title: 'Levitating', artist: 'Dua Lipa'),
    Song(id: '4', title: 'Stay', artist: 'Justin Bieber'),
  ];

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) newIndex--;
      final song = _songs.removeAt(oldIndex);
      _songs.insert(newIndex, song);
    });
  }

  void _removeSong(int index) {
    final removed = _songs[index];
    setState(() => _songs.removeAt(index));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Removed "${removed.title}"'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('🎵 Song Ranking'), centerTitle: true),
      body: ReorderableListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _songs.length,
        onReorder: _onReorder,
        buildDefaultDragHandles: false,
        itemBuilder: (context, index) {
          final song = _songs[index];

          return Dismissible(
            key: ValueKey(song.id),
            direction: DismissDirection.endToStart,
            onDismissed: (_) => _removeSong(index),
            background: _dismissBackground(),
            child: _songCard(song, index),
          );
        },
      ),
    );
  }

  /// UI Card ของเพลง
  Widget _songCard(Song song, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: _rankBadge(index),
        title: Text(
          song.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(song.artist),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () => _removeSong(index),
            ),
            ReorderableDragStartListener(
              index: index,
              child: const Icon(Icons.drag_handle),
            ),
          ],
        ),
      ),
    );
  }

  /// Badge แสดงอันดับ
  Widget _rankBadge(int index) {
    return CircleAvatar(
      radius: 18,
      backgroundColor: Colors.deepPurple,
      child: Text(
        '#${index + 1}',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /// พื้นหลังตอนปัดลบ
  Widget _dismissBackground() {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 24),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Icon(Icons.delete, color: Colors.white, size: 28),
    );
  }
}
