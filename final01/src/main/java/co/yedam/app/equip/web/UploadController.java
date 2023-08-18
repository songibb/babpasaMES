package co.yedam.app.equip.web;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class UploadController {
	
	@Value("${file.upload.path}") //특정 필드 위에 @value해주면 밸류 값을 기준으로 ${}를 이용해서 외부 데이터를 가져오고 해당 필드에 넣어줌.
	private String uploadPath;
	
	//페이지
	@GetMapping("upload")
	public void getUploadPage() {
		
	}
	//처리
	@PostMapping("/uploadsAjax")
	@ResponseBody
	public List<String> uploadFile(@RequestPart MultipartFile[] uploadFiles) { //@이 있음에도 불구하고 requestpart는 beans에 resolver등록해야함. []은 데이터 여러개 바들때 하고 하나면 안해도 됨.
	    
		List<String> imageList = new ArrayList<>();
		
		//이 for문은 이미자만 돌리
	    for(MultipartFile uploadFile : uploadFiles){
	    	if(uploadFile.getContentType().startsWith("image") == false){
	    		System.err.println("this file is not image type");
	    		return null;
	        }
	   
	    	//경로생성하는 코드 try전까지
	        String originalName = uploadFile.getOriginalFilename(); //사용자가 보낸 파일 끌고 들어오는 코드
	        String fileName = originalName.substring(originalName.lastIndexOf("//")+1); //사용자가 보낸 파일 끌고 들어오는 코드
	        
	        System.out.println("fileName : " + fileName);
	    
	        //날짜 폴더 생성
	        String folderPath = makeFolder();
	        //UUID
	        String uuid = UUID.randomUUID().toString(); //시간을기준으로 유니크한 값을 가져옴.
	        //저장할 파일 이름 중간에 "_"를 이용하여 구분
	        
	        String uploadFileName = folderPath +File.separator + uuid + "_" + fileName; //해당폴더 밑에 uuid를 기준으로 하는 어떠한 폴더가 생성됨.
	        
	        String saveName = uploadPath + File.separator + uploadFileName; //실제 경로.
	        
	        Path savePath = Paths.get(saveName); //파일시스템이 가지고 있는 실제 경로를 저장하는 클래스인 Path를 이용해서 자바가 인식할수 있는 형태로 변환함.
	        //Paths.get() 메서드는 특정 경로의 파일 정보를 가져옵니다.(경로 정의하기)
	        System.out.println("path : " + saveName);
	        
	        //파일 업로드 하는 실질적인 부분
	        try{
	        	uploadFile.transferTo(savePath);
	            //uploadFile에 파일을 업로드 하는 메서드 transferTo(file)
	        } catch (IOException e) {
	             e.printStackTrace();	             
	        }
	        //DB에 저장
	        //풀네임(saveName) 사용하면 안됨. -uploadFileName을 사용
	        imageList.add(setImagePath(uploadFileName));
	     }
	    
	    return imageList;
	}
	
	private String makeFolder() {
		String str = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy/MM/dd")); //오늘 날짜를 가지고옴 -> 특정한 패턴으로 변경.
		// LocalDate를 문자열로 포멧
		String folderPath = str.replace("/", File.separator); //자바는 /를 파일 구분으로 인식하지 않음.
		File uploadPathFoler = new File(uploadPath, folderPath); //실질적인 파일 경로를 지정하고 붙이는 과정.
		// File newFile= new File(dir,"파일명");
		if (uploadPathFoler.exists() == false) { //폴더 자동생성 if문
			uploadPathFoler.mkdirs();
			// 만약 uploadPathFolder가 존재하지않는다면 makeDirectory하라는 의미입니다.
			// mkdir(): 디렉토리에 상위 디렉토리가 존재하지 않을경우에는 생성이 불가능한 함수
			// mkdirs(): 디렉토리의 상위 디렉토리가 존재하지 않을 경우에는 상위 디렉토리까지 모두 생성하는 함수
		}
		return folderPath; //생성완료되면 해당 경로 반환.
	}
	
	private String setImagePath(String uploadFileName) {
		return uploadFileName.replace(File.separator, "/");
	}
}
