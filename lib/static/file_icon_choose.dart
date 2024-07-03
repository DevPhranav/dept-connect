class FileIconChoose{

  String getIcon(String extension)
  {
    String iconData='';
    switch (extension) {
      case 'pdf':
        iconData = 'pdf';
        break;
      case 'xls':
      case 'xlsx':
        iconData = 'excel';
        break;
      case 'png':
      case 'jpg':
      case 'jpeg':
        iconData = 'image-file';
        break;
      case 'doc':
      case 'docx':
        iconData = 'doc';
        break;
      case 'ppt':
      case 'pptx':
        iconData = 'ppt';
        break;
      default:
        iconData = 'document';
    }

    return iconData;
  }


}