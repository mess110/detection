package detect.api.models;

import java.util.ArrayList;

public class Image {

	private int id;
	private String status;
	private String url;
	private int estimatedTimeOfArrival;
	private ArrayList<Region> regions;
	
	public static final String STATUS_COMPLETED = "completed";
	public static final String STATUS_FAILED = "failed";
	public static final String STATUS_PROCESSING = "processing";

	public Image() {
		regions = new ArrayList<Region>();
	}
	
	public void addRegion(Region r) {
		regions.add(r);
	}
	
	public boolean isCompleted() {
		return getStatus().equals(STATUS_COMPLETED);
	}
	
	public ArrayList<Region> getRegions() {
		return regions;
	}
	public void setRegions(ArrayList<Region> regions) {
		this.regions = regions;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public int getEstimatedTimeOfArrival() {
		return estimatedTimeOfArrival;
	}
	public void setEstimatedTimeOfArrival(int estimatedTimeOfArrival) {
		this.estimatedTimeOfArrival = estimatedTimeOfArrival;
	}
}
