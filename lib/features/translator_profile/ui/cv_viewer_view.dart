import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:translator/core/theme/app_colors.dart';
import 'package:translator/core/widgets/app_loading_indecator.dart';
import 'package:translator/core/widgets/custom_app_icon.dart';
import 'package:translator/features/home/ui/widgets/title_text_widet.dart';

class CvViewerView extends StatefulWidget {
  final String pdfUrl;

  const CvViewerView({super.key, required this.pdfUrl});

  @override
  State<CvViewerView> createState() => _CvViewerViewState();
}

class _CvViewerViewState extends State<CvViewerView> {
  String? localPath;
  bool isLoading = true;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    try {
      // Get app cache directory
      final dir = await getTemporaryDirectory();
      final fileName = widget.pdfUrl.split('/').last; // Get file name from URL
      final filePath = '${dir.path}/$fileName';
      final file = File(filePath);

      if (await file.exists()) {
        // If file exists, use it
        setState(() {
          localPath = filePath;
          isLoading = false;
        });
      } else {
        // Download the file and cache it
        await Dio().download(widget.pdfUrl, filePath);
        setState(() {
          localPath = filePath;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isError = true;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const CustomAppIcon(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const TitleTextWidet(
          title: 'CV Viewer',
          fontSize: 20,
        ),
        actions: [
          if (localPath != null)
            IconButton(
              icon: const Icon(Icons.refresh, color: AppColors.mainBlue),
              onPressed: () {
                setState(() {
                  isLoading = true;
                });
                _loadPdf(); // Refresh file
              },
            )
        ],
      ),
      body: isLoading
          ? const AppLoadingIndecator()
          : isError
              ? const Center(
                  child: TitleTextWidet(
                      title: 'Error loading PDF', textColor: Colors.red),
                )
              : SfPdfViewer.file(
                  File(localPath!),
                ),
    );
  }
}
