package kr.co.hn.util;

// 참고 : https://blog.naver.com/PostView.nhn?blogId=heartflow89&logNo=221014400238&redirect=Dlog&widgetTypeCall=true&directAccess=false

public class PagingUtil {
	
	private final int rowSize = 10;	// 한페이지 내의 글 갯수
	private final int blockSize = 5;  // 화면에 보이는 페이지 블록의 갯수
	private int curPage; 		// 현재 페이지
	private int totalRow; 		// 전체 글 갯수
	
	private int totalPage;		// 전체 페이지 갯수
	private int startRow; 		// 시작 글번호
	private int endRow; 		// 끝 글번호
	private int curBlock;		// 
	private int startPage; 		// 시작 페이지
	private int endPage;  		// 끝 페이지
	
	
	// 생성자
	public PagingUtil() {
	}

	public PagingUtil(int totalRow, int curPage) {
		super();
		this.totalRow = totalRow;
		this.curPage = curPage;
		this.startRow = getStartRow(this.curPage, rowSize);
		this.endRow = getEndRow(this.curPage, rowSize, this.totalRow);
		this.totalPage = getTotalPage(totalRow, rowSize);
		this.curBlock = getCurBlock(this.curPage, blockSize);
		this.startPage = getStartPage(this.curBlock);
		this.endPage = getEndPage(this.startPage, this.totalPage);
	}

	// getter/setter
	public int getTotalRow() {
		return totalRow;
	}

	public void setTotalRow(int totalRow) {
		this.totalRow = totalRow;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getCurPage() {
		return curPage;
	}

	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}

	public int getCurBlock() {
		return curBlock;
	}

	public void setCurBlock(int curBlock) {
		this.curBlock = curBlock;
	}

	public int getStartRow() {
		return startRow;
	}

	public void setStartRow(int startRow) {
		this.startRow = startRow;
	}

	public int getEndRow() {
		return endRow;
	}

	public void setEndRow(int endRow) {
		this.endRow = endRow;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public int getRowSize() {
		return rowSize;
	}

	public int getBlockSize() {
		return blockSize;
	}
	
	// 클릭한 페이지의 시작 글번호
	public int getStartRow(int curPage, int rowSize) {
		return (curPage - 1) * rowSize + 1;
	}
	
	// 클릭한 페이지의 끝 번호
	public int getEndRow(int curPage, int rowSize, int totalRow) {
		int endRow = curPage * rowSize; // 끝 글번호는 전체 글 수보다 많으면 안됨
		if(endRow > totalRow) {
			endRow = totalRow;
		}
		
		return endRow;
	}
	
	// 전체 페이지 갯수
	public int getTotalPage(int totalRow, int rowSize) {
		return (int) Math.ceil(totalRow * 1.0 / rowSize);
	}
	
	
	// 현재 속한 블록의 번호
	public int getCurBlock(int curPage, int blockSize) {
		int curBlock =(int) Math.round((curPage - 1 + blockSize) / blockSize);
		return curBlock;
	}
	
	// 현재 속한 블록의 시작번호
	public int getStartPage(int curBlock) {
		int startPage =  (curBlock- 1) * 5 + 1 ;
		return startPage;
	}
	
	// 현재 속한 블록의 끝번호
	public int getEndPage(int startPage, int totalPage) {
		int endPage = startPage + 4;
		
		if(endPage > totalPage)
			endPage = totalPage;
		
		return endPage;
	}
	
	
	
	
	
	
	
	public static void main(String[] args) {
		PagingUtil util = new PagingUtil(123, 13);
		int start = util.getStartRow();
		int end = util.getEndRow();
		
	}
	
	
}
