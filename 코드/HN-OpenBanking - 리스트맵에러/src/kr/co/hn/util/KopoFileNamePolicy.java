package kr.co.hn.util;

import java.io.File;
import java.util.UUID;

import com.oreilly.servlet.multipart.FileRenamePolicy;

public class KopoFileNamePolicy implements FileRenamePolicy {

	@Override
	public File rename(File f) {
		String name = f.getName();
		String ext = "";
		int dot = name.lastIndexOf(".");
		if (dot != -1) {
			ext = name.substring(dot); 
		} else {
			ext = "";
		}
		String str = "kopo" + UUID.randomUUID(); // 32bit
		File renameFile = new File(f.getParent(), str + ext);
		return renameFile;
	}
	
}
