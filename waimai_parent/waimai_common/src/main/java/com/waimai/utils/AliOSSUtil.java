package com.waimai.utils;

import com.aliyun.oss.ClientException;
import com.aliyun.oss.OSS;
import com.aliyun.oss.OSSClientBuilder;
import com.aliyun.oss.OSSException;
import com.aliyun.oss.model.GetObjectRequest;
import com.aliyun.oss.model.OSSObject;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.apache.http.HttpResponse;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@Data
@AllArgsConstructor
@Builder
@Slf4j
public class AliOSSUtil {

    private String endpoint;
    private String accessKeyId;
    private String accessKeySecret;
    private String bucketName;

    /**
     * 文件上传
     *
     * @param bytes
     * @param objectName
     * @return
     */
    public String upload(byte[] bytes, String objectName) {

        // 创建OSSClient实例。
        OSS ossClient = new OSSClientBuilder().build(endpoint, accessKeyId, accessKeySecret);

        try {
            // 创建PutObject请求。
            ossClient.putObject(bucketName, objectName, new ByteArrayInputStream(bytes));
        } catch (OSSException oe) {
            System.out.println("Caught an OSSException, which means your request made it to OSS, "
                    + "but was rejected with an error response for some reason.");
            System.out.println("Error Message:" + oe.getErrorMessage());
            System.out.println("Error Code:" + oe.getErrorCode());
            System.out.println("Request ID:" + oe.getRequestId());
            System.out.println("Host ID:" + oe.getHostId());
        } catch (ClientException ce) {
            System.out.println("Caught an ClientException, which means the client encountered "
                    + "a serious internal problem while trying to communicate with OSS, "
                    + "such as not being able to access the network.");
            System.out.println("Error Message:" + ce.getMessage());
        } finally {
            if (ossClient != null) {
                ossClient.shutdown();
            }
        }

        //文件访问路径规则 https://BucketName.Endpoint/ObjectName
        StringBuilder stringBuilder = new StringBuilder("https://");
        stringBuilder
                .append(bucketName)
                .append(".")
                .append(endpoint)
                .append("/")
                .append(objectName);

        log.info("文件上传到:{}", stringBuilder.toString());

        return stringBuilder.toString();
    }


//    public ResponseEntity<InputStreamResource> download(String name) {
//        OSS ossClient = null;
//        InputStream inputStream = null;
//        try {
//            URL fileUrl = new URL(name);
//            String path = fileUrl.getPath();
//            String objectKey = path.substring(1);
//
//            ossClient = new OSSClientBuilder().build(endpoint, accessKeyId, accessKeySecret);
//
//            GetObjectRequest getObjectRequest = new GetObjectRequest(bucketName, objectKey);
//            OSSObject ossObject = ossClient.getObject(getObjectRequest);
//
//            inputStream = ossObject.getObjectContent();
//
//            HttpHeaders headers = new HttpHeaders();
//            String encodedFilename = URLEncoder.encode(objectKey, StandardCharsets.UTF_8);
//            headers.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + encodedFilename + "\"");
//
//            String contentType = "application/octet-stream";
//            if (objectKey.endsWith(".jpg") || objectKey.endsWith(".jpeg")) {
//                contentType = "image/jpeg";
//            } else if (objectKey.endsWith(".png")) {
//                contentType = "image/png";
//            } else if (objectKey.endsWith(".gif")) {
//                contentType = "image/gif";
//            }
//            headers.add(HttpHeaders.CONTENT_TYPE, contentType);
//
//            return ResponseEntity.ok()
//                    .headers(headers)
//                    .body(new InputStreamResource(inputStream));
//
//        } catch (Exception e) {
//            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
//        } finally {
//            if (ossClient != null) {
//                ossClient.shutdown();
//            }
//            // 不要在这里关闭 inputStream
//        }
//    }
}
